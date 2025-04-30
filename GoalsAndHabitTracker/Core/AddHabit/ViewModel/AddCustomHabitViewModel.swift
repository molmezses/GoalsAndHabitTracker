//
//  AddCustomHabitViewModel.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 25.04.2025.
//

import SwiftUI
import Foundation


class AddCustomHabitViewModel: ObservableObject {
    
    @Published var habits: [Habit] = []
    private let habitService = HabitService()
        
    @Published var title: String = ""
    @Published var selectedEmoji: String = "🔥"
    @Published var color: Color = .red
    @Published var showingColorSheet: Bool = false
    @Published var showingEmojiSheet: Bool = false
    @Published var targetAmount: String = "100"
    @Published var selectedUnit: String = "Adet"
    @Published var reminderIsOn: Bool = false
    @Published var reminderTime: Date = Date()
    @Published var weekdays: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    @Published var selectedDays: Set<String> = []
    @Published var animate: Bool = false
    @Published var rapor: Bool = false
    @Published var colors: [Color] = [
        Color(hex: "#FF3B30"), // Kırmızı
        Color(hex: "#34C759"), // Yeşil
        Color(hex: "#007AFF"), // Mavi
        Color(hex: "#FF9500"), // Turuncu
        Color(hex: "#AF52DE")  // Mor
    ]

    

    init() {
        Task {
            for await newHabits in habitService.listenHabits() {
                await MainActor.run {
                    self.habits = newHabits
                }
            }
        }
    }
    

    func createHabit() {
        let habit = Habit(
            id: UUID().uuidString,
            title: title,
            emoji: selectedEmoji,
            current: 0,
            total: Double(targetAmount) ?? 100,
            colorHex: color.toHex() ?? "#FF0000",
            isCompleted: false,
            sound: "",
            category: selectedUnit,
            reminderTime: reminderTime,
            reminderDays: "Everyday",
            complatedDay: [],
            missing: 0,
            longestSeries: 0,
            startingDay: formattedDayMonth(from: Date())
        )

        Task {
            try await habitService.addHabit(habit)
        }
    }
    
    func formattedDayMonth(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX") // Tarafsız sabit format
        formatter.dateFormat = "d MMMM" // 29 April
        return formatter.string(from: date)
    }
    
    
}



