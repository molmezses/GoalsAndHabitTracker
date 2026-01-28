//
//  ProgressViewModel.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 28.04.2025.
//

import Foundation
import Firebase
import FirebaseFirestore

enum ProgressStyle: Int, CaseIterable {
    case circular = 1      // Dairesel (mevcut)
    case linearBar = 2     // Yatay çubuk
    case halfCircle = 3    // Yarım daire
    case wave = 4          // Dalga animasyonlu
    
    var icon: String {
        switch self {
        case .circular: return "circle"
        case .linearBar: return "rectangle.fill"
        case .halfCircle: return "semicircle.fill"
        case .wave: return "waveform.path"
        }
    }
    
    var name: String {
        switch self {
        case .circular: return "Circular"
        case .linearBar: return "Linear"
        case .halfCircle: return "Half Circle"
        case .wave: return "Wave"
        }
    }
}

class ProgressViewModel: ObservableObject {
    
    @Published  var showSheet = false
    @Published  var showPopupMenu = false
    @Published var animate: Bool = false
    @Published var progressStyle: ProgressStyle = .circular {
        didSet {
            saveProgressStyle()
        }
    }
    @Published var showStylePicker: Bool = false
    @Published var showValueInput: Bool = false
    @Published var customValueText: String = ""
    @Published var showCelebration: Bool = false
    @Published var celebrationMessage: String = ""
    @Published var showNotes: Bool = false
    @Published var noteText: String = ""
    @Published var showNoteEditor: Bool = false
    
    private let progressStyleKey = "selectedProgressStyle"
    
    // Motivational messages
    private let motivationalMessages: [String] = [
        "Every small step counts! Keep going! 💪",
        "You're doing amazing! Consistency is key! 🌟",
        "Progress, not perfection! You've got this! ✨",
        "Small daily improvements lead to big results! 🚀",
        "You're stronger than you think! Keep pushing! 💫",
        "Every day is a fresh start! Make it count! 🌈",
        "Your future self will thank you! Keep going! 🎯",
        "You're building something great! Stay focused! 🔥",
        "One day at a time! You're making progress! ⭐",
        "Believe in yourself! You can do this! 🌺",
        "Every effort matters! Keep moving forward! 💎",
        "You're on the right track! Stay committed! 🎊",
        "Small steps lead to big changes! Keep it up! 🌻",
        "Your dedication is inspiring! Keep going! 🏆",
        "Every moment counts! You're doing great! 🌟"
    ]
    
    func getRandomMotivationalMessage() -> String {
        return motivationalMessages.randomElement() ?? "Keep going! You've got this! 💪"
    }
    
    func formattedTodayDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: Date())
    }
    
    func getTodayNote(for habit: Habit) -> String {
        let today = formattedTodayDate()
        return habit.dailyNotes[today] ?? ""
    }
    
    func saveNote(for habit: inout Habit, note: String) {
        let today = formattedTodayDate()
        if note.isEmpty {
            habit.dailyNotes.removeValue(forKey: today)
        } else {
            habit.dailyNotes[today] = note
        }
    }
    
    init() {
        loadProgressStyle()
    }
    
    private func saveProgressStyle() {
        UserDefaults.standard.set(progressStyle.rawValue, forKey: progressStyleKey)
    }
    
    private func loadProgressStyle() {
        let savedValue = UserDefaults.standard.integer(forKey: progressStyleKey)
        if let style = ProgressStyle(rawValue: savedValue) {
            progressStyle = style
        }
    }
    
    
    
    
    
    func deleteHabit(habit: Habit, completion: @escaping (Bool) -> Void = { _ in }) {
        guard let habitId = habit.id else {
            print("HATA: Habit ID bulunamadı")
            showPopupMenu = false
            completion(false)
            return
        }
        
        print("Habit siliniyor: \(habit.title) (ID: \(habitId))")
        
        // Firestore'dan sil (notification kaldırma işlemi FirestoreManager içinde yapılıyor)
        FirestoreManager.sharedFirestoreManager
            .deleteHabit(habit) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        print("Habit başarıyla silindi: \(habit.title)")
                        self?.showPopupMenu = false
                        completion(true)
                    case .failure(let error):
                        print("Silme hatası: \(error.localizedDescription)")
                        // Hata durumunda da popup'ı kapat
                        self?.showPopupMenu = false
                        completion(false)
                        // Hata mesajı göster (isteğe bağlı - alert eklenebilir)
                    }
                }
            }
    }
    
    
    
    func disableButton(habit: Habit) -> Bool {
        switch habit.countingMode {
        case .forward:
            return habit.current >= habit.total
        case .backward:
            return habit.current <= 0
        case .timer:
            return habit.timerElapsed >= habit.timerTarget && habit.timerTarget > 0
        }
    }
    
    //    Eğer habit bir struct türünde ise ve bu struct içinde diziyi değiştirmeye çalışıyorsanız, struct'ın fonksiyonunu mutating olarak işaretlemeniz gerekir. Aksi takdirde, bu türdeki veri yapıları değiştirilemez.
    
    func removeTodayIfCompleted(habit: inout Habit){
        let today = formattedTodayDate()
        habit.complatedDay.removeAll{ $0 == today }
    }
    
    func daysBetweenTodayAnd(start: String) -> Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US")
        
        // Bugünün yılını al ve start stringine ekle (örneğin: "12 April" + " 2025")
        let currentYear = Calendar.current.component(.year, from: Date())
        let startWithYear = "\(start) \(currentYear)"
        
        guard let startDate = formatter.date(from: startWithYear) else {
            print("Tarih formatı hatalı.")
            return nil
        }
        
        let endDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        return components.day
    }
    
    func calcMissingDay(habit: Habit) -> Int {
        let totalDays = daysBetweenTodayAnd(start: habit.startingDay) ?? 0
        return max(totalDays - habit.complatedDay.count, 0)
    }
    
    // Üst üste en uzun seriyi hesapla
    func calculateLongestSeries(_ habit: Habit) -> Int {
        guard !habit.complatedDay.isEmpty else { return 0 }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US")
        
        // Tarihleri sırala
        let sortedDates = habit.complatedDay.compactMap { formatter.date(from: $0) }.sorted()
        
        guard !sortedDates.isEmpty else { return 0 }
        
        var longestStreak = 1
        var currentStreak = 1
        
        let calendar = Calendar.current
        
        for i in 1..<sortedDates.count {
            if let daysBetween = calendar.dateComponents([.day], from: sortedDates[i-1], to: sortedDates[i]).day {
                if daysBetween == 1 {
                    // Üst üste günler
                    currentStreak += 1
                    longestStreak = max(longestStreak, currentStreak)
                } else {
                    // Seri kırıldı
                    currentStreak = 1
                }
            }
        }
        
        return longestStreak
    }
    
    // Habit güncellendiğinde longestSeries'i hesapla ve güncelle
    func updateLongestSeries(habit: inout Habit) {
        habit.longestSeries = calculateLongestSeries(habit)
    }
    
    // Celebration tetikle
    func triggerCelebration(habit: Habit) {
        let messages = [
            "Harika! 🎉",
            "Mükemmel! ✨",
            "Tebrikler! 🏆",
            "Başardın! 🎊",
            "Süpersin! ⭐",
            "Harika iş! 🌟"
        ]
        celebrationMessage = messages.randomElement() ?? "Tebrikler! 🎉"
        showCelebration = true
        
        // 3 saniye sonra otomatik kapat
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.showCelebration = false
        }
    }

    
    
    
    
}
