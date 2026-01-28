//
//  UpdateViewModel.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 30.04.2025.
//

import SwiftUI
import Foundation


class UpdateViewModel: ObservableObject {
    
    private let habitService = HabitService()
    
    
    @Published var title: String = ""
    @Published var selectedEmoji: String = ""
    @Published var color: Color = .red
    @Published var current: Double = 1
    @Published var showingColorSheet: Bool = false
    @Published var showingEmojiSheet: Bool = false
    @Published var completedDay: [String] = []
    @Published var targetAmount: String = ""
    @Published var selectedUnit: String = ""
    @Published var reminderIsOn: Bool = false
    @Published var reminderTime: Date = Date()
    @Published var reminderMessage: String = ""
    @Published var sound: String = "update"
    @Published var weekdays: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    @Published var selectedDays: Set<String> = []
    @Published var animate: Bool = false
    @Published var missing: Int = 0
    @Published var longestSeries: Int = 0
    @Published var rapor: Bool = false
    @Published var startingDay:String = ""
    @Published var countingMode: CountingMode = .forward
    @Published var timerTargetHours: String = "0"
    @Published var timerTargetMinutes: String = "30"
    @Published var colors: [Color] = [
        Color(hex: "#FF3B30"), Color(hex: "#FF5B00"), Color(hex: "#FF7F00"), Color(hex: "#FF9F00"), Color(hex: "#FFBF00"), // Turuncu tonları
        Color(hex: "#34C759"), Color(hex: "#4CDE6A"), Color(hex: "#66E178"), Color(hex: "#7FF684"), Color(hex: "#99F490"), // Yeşil tonları
        Color(hex: "#007AFF"), Color(hex: "#338CFF"), Color(hex: "#66A9FF"), Color(hex: "#99C6FF"), Color(hex: "#CCE3FF"), // Mavi tonları
        Color(hex: "#FF9500"), Color(hex: "#FFB500"), Color(hex: "#FFCF00"), Color(hex: "#FFD700"), Color(hex: "#FFEA00"), // Sarı tonları
        Color(hex: "#AF52DE"), Color(hex: "#B266E0"), Color(hex: "#B97EE4"), Color(hex: "#C198E7"), Color(hex: "#C8A9EC"), // Mor tonları
        Color(hex: "#B63D51"), Color(hex: "#C94C5A"), Color(hex: "#D95C6B"), Color(hex: "#E56D7D"), Color(hex: "#F07E8E"), // Kırmızı tonları
        Color(hex: "#6A5ACD"), Color(hex: "#7B66D3"), Color(hex: "#8C72D9"), Color(hex: "#9D7FDE"), Color(hex: "#AE8C9A"), // Lavanta tonları
        Color(hex: "#FFC0CB"), Color(hex: "#FF8FB1"), Color(hex: "#FF5D8F"), Color(hex: "#FF2A6D"), Color(hex: "#FF004B"), // Pembe tonları
        Color(hex: "#8B4513"), Color(hex: "#A04F19"), Color(hex: "#B05A1E"), Color(hex: "#C06623"), Color(hex: "#D17329"), // Kahverengi tonları
        Color(hex: "#32CD32"), Color(hex: "#3DDF39"), Color(hex: "#4AED40"), Color(hex: "#59FB47"), Color(hex: "#64FF4E"), // Asfalt yeşili tonları
        Color(hex: "#1E90FF"), Color(hex: "#3399FF"), Color(hex: "#4C82FF"), Color(hex: "#668CFF"), Color(hex: "#7996FF"), // Koyu mavi tonları
        Color(hex: "#DA70D6"), Color(hex: "#E066D9"), Color(hex: "#F060DC"), Color(hex: "#F465E0"), Color(hex: "#F870E4"), // Orkide tonları
        Color(hex: "#FF6347"), Color(hex: "#FF5E41"), Color(hex: "#FF5733"), Color(hex: "#FF451E"), Color(hex: "#FF3400"), // Domates kırmızı tonları
        Color(hex: "#98FB98"), Color(hex: "#A4FF9C"), Color(hex: "#B0FF8A"), Color(hex: "#B5FF76"), Color(hex: "#C0FF63"), // Nane yeşili tonları
        Color(hex: "#800080"), Color(hex: "#A100A1"), Color(hex: "#B500B5"), Color(hex: "#D000D0"), Color(hex: "#E600E6"), // Mor tonları
        Color(hex: "#FFE4E1"), Color(hex: "#FFD1D1"), Color(hex: "#FFB0B0"), Color(hex: "#FF8F8F"), Color(hex: "#FF6E6E"), // Açık kırmızı tonları
        Color(hex: "#8A2BE2"), Color(hex: "#9B39E1"), Color(hex: "#A747E0"), Color(hex: "#B855DF"), Color(hex: "#C764DE"), // Mavi-mor tonları
        Color(hex: "#48C9B0"), Color(hex: "#60D1B9"), Color(hex: "#71D8C2"), Color(hex: "#82E0CC"), Color(hex: "#93E7D5"), // Mint yeşili tonları
        Color(hex: "#D2691E"), Color(hex: "#E3772C"), Color(hex: "#F3853B"), Color(hex: "#FF8F49"), Color(hex: "#FF9A56"), // Çikolata tonları
        Color(hex: "#F0E68C"), Color(hex: "#E3DA5C"), Color(hex: "#D6D14C"), Color(hex: "#C9C23C"), Color(hex: "#BDB72C"), // Altın sarısı tonları
        Color(hex: "#006400"), Color(hex: "#007700"), Color(hex: "#009900"), Color(hex: "#00B300"), Color(hex: "#00CC00"), // Orman yeşili tonları
        Color(hex: "#DC143C"), Color(hex: "#D50032"), Color(hex: "#C10026"), Color(hex: "#B0001A"), Color(hex: "#9C0010"), // Koyu kırmızı tonları
        Color(hex: "#7FFF00"), Color(hex: "#7DFF00"), Color(hex: "#6DFF00"), Color(hex: "#5DFF00"), Color(hex: "#4DFF00"), // Yeşil sarısı tonları
        Color(hex: "#00CED1"), Color(hex: "#00B5B3"), Color(hex: "#009C9F"), Color(hex: "#008388"), Color(hex: "#006E73"), // Denizin mavisi tonları
        Color(hex: "#D3D3D3"), Color(hex: "#B0B0B0"), Color(hex: "#A0A0A0"), Color(hex: "#808080"), Color(hex: "#707070") // Gri tonları
    ]

    
    func loadHabit(habit: Habit){
        title = habit.title
        selectedEmoji = habit.emoji
        color = habit.color
        targetAmount = ("\(habit.total)")
        selectedUnit = habit.category
        reminderTime = habit.reminderTime
        reminderMessage = habit.reminderMessage
        completedDay = habit.complatedDay
        current = habit.current
        startingDay = habit.startingDay
        missing = habit.missing
        longestSeries = habit.longestSeries
        sound = habit.sound
        countingMode = habit.countingMode
        if habit.timerTarget > 0 {
            let hours = Int(habit.timerTarget) / 3600
            let minutes = (Int(habit.timerTarget) % 3600) / 60
            timerTargetHours = "\(hours)"
            timerTargetMinutes = "\(minutes)"
        }
    }

    

    func createHabit(habit: Habit, soundVM : SoundViewModel) {
        // Timer modu için hedef süreyi hesapla (saniye cinsinden)
        var timerTarget: Double = habit.timerTarget
        if countingMode == .timer {
            let hours = Double(timerTargetHours) ?? 0
            let minutes = Double(timerTargetMinutes) ?? 0
            timerTarget = (hours * 3600) + (minutes * 60)
        }
        
        let updatedHabit = Habit(
            id: habit.id,
            title: title,
            emoji: selectedEmoji,
            current: habit.current,
            total: Double(targetAmount) ?? 100,
            colorHex: color.toHex() ?? "#FF0000",
            isCompleted: false,
            sound: soundVM.selectedSound,
            category: selectedUnit,
            reminderTime: reminderTime,
            reminderDays: "Everyday",
            reminderMessage: reminderMessage,
            complatedDay: habit.complatedDay,
            missing: missing,
            longestSeries: longestSeries,
            startingDay: startingDay,
            countingMode: countingMode,
            timerElapsed: habit.timerElapsed,
            timerTarget: timerTarget,
            isTimerRunning: false,
            dailyNotes: habit.dailyNotes
        )

        Task {
            try await habitService.updateHabit(updatedHabit)
        }
    }
    
    func formattedDayMonth(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX") // Tarafsız sabit format
        formatter.dateFormat = "d MMMM" // 29 April
        return formatter.string(from: date)
    }
    
    
}
