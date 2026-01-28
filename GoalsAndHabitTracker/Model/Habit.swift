//
//  Habit.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 22.04.2025.
//

import Foundation
import SwiftUI
import FirebaseFirestore

// Sayım modu enum'u
enum CountingMode: String, Codable, CaseIterable {
    case forward = "forward"      // 0'dan hedefe (sıfırdan sonuca)
    case backward = "backward"    // Hedeften 0'a (sonuctan sıfıra)
    case timer = "timer"          // Kronometre modu
    
    var displayName: String {
        switch self {
        case .forward: return "Forward (0 → Target)"
        case .backward: return "Backward (Target → 0)"
        case .timer: return "Timer/Stopwatch"
        }
    }
    
    var description: String {
        switch self {
        case .forward: return "Count from zero to target"
        case .backward: return "Start from target, count down to zero"
        case .timer: return "Track time spent"
        }
    }
}

struct Habit: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var emoji: String
    var current: Double
    var total: Double
    var colorHex: String
    var isCompleted: Bool
    var sound: String
    var category: String
    var reminderTime: Date
    var reminderDays: String
    var reminderMessage: String
    var complatedDayCount: Int {
        return complatedDay.count
    }
    var complatedDay: [String]
    var missing: Int
    var longestSeries: Int
    var startingDay: String
    var countingMode: CountingMode = .forward  // Yeni: Sayım modu
    var timerElapsed: Double = 0  // Yeni: Kronometre için geçen süre (saniye)
    var timerTarget: Double = 0  // Yeni: Kronometre hedef süre (saniye)
    var isTimerRunning: Bool = false  // Yeni: Kronometre çalışıyor mu?
    var dailyNotes: [String: String] = [:]  // Yeni: Günlük notlar (date: note)

    // colorHex'i kullanarak hesaplanan yardımcı alan
    var color: Color {
        Color(hex: colorHex)
    }
    var lastUpdated: Date?
    
    // İlerleme yüzdesi (moda göre hesaplanır)
    var progressPercentage: Double {
        switch countingMode {
        case .forward:
            guard total > 0 else { return 0 }
            return min(current / total, 1.0)
        case .backward:
            // Backward modunda: current azaldıkça progress artar (0'a yaklaştıkça tamamlanır)
            guard total > 0 else { return 0 }
            let remaining = max(0, current)
            return min((total - remaining) / total, 1.0)
        case .timer:
            guard timerTarget > 0 else { return 0 }
            return min(timerElapsed / timerTarget, 1.0)
        }
    }
    
    // Tamamlanma kontrolü (moda göre)
    var isCompletedByMode: Bool {
        switch countingMode {
        case .forward:
            return current >= total
        case .backward:
            return current <= 0
        case .timer:
            return timerElapsed >= timerTarget
        }
    }
    
    // Görüntülenecek değer (moda göre)
    var displayValue: String {
        switch countingMode {
        case .forward:
            return "\(Int(current))/\(Int(total))"
        case .backward:
            // Backward modunda: Kalan değeri göster (current değeri)
            return "\(Int(max(0, current)))/\(Int(total))"
        case .timer:
            return formatTime(timerElapsed)
        }
    }
    
    // Zaman formatı
    private func formatTime(_ seconds: Double) -> String {
        let hours = Int(seconds) / 3600
        let minutes = (Int(seconds) % 3600) / 60
        let secs = Int(seconds) % 60
        
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, secs)
        } else {
            return String(format: "%d:%02d", minutes, secs)
        }
    }
}


extension Habit{
    static var MOCK_HABIT: [Habit] = [
        Habit(title: "asdasd", emoji: "😁", current: 78, total: 250, colorHex: "324234", isCompleted: true, sound: "sdfsfd", category: "eda", reminderTime: Date(), reminderDays: "", reminderMessage: "", complatedDay: ["29 April 2025" , "12 April 2025"], missing: 0, longestSeries: 0, startingDay: "", countingMode: .forward, timerElapsed: 0, timerTarget: 0, isTimerRunning: false, dailyNotes: [:]),
        Habit(title: "asdasd", emoji: "😁", current: 0, total: 0, colorHex: "324234", isCompleted: true, sound: "sdfsfd", category: "eda", reminderTime: Date(), reminderDays: "",  reminderMessage: "", complatedDay: ["29 April 2025" , "12 April 2025"], missing: 0, longestSeries: 0, startingDay: "", countingMode: .forward, timerElapsed: 0, timerTarget: 0, isTimerRunning: false, dailyNotes: [:]),
        Habit(title: "123123123", emoji: "😁", current: 0, total: 0, colorHex: "324234", isCompleted: true, sound: "sdfsfd", category: "eda", reminderTime: Date(), reminderDays: "", reminderMessage: "", complatedDay: ["29 April 2025" , "12 April 2025"], missing: 0, longestSeries: 0, startingDay: "", countingMode: .forward, timerElapsed: 0, timerTarget: 0, isTimerRunning: false, dailyNotes: [:])
    ]
}
