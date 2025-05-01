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
    @Published var showingColorSheet: Bool = false
    @Published var showingEmojiSheet: Bool = false
    @Published var completedDay: [String] = []
    @Published var targetAmount: String = ""
    @Published var selectedUnit: String = ""
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
    
    func loadHabit(habit: Habit){
        title = habit.title
        selectedEmoji = habit.emoji
        color = habit.color
        targetAmount = ("\(habit.total)")
        selectedUnit = habit.category
        reminderTime = habit.reminderTime
        completedDay = habit.complatedDay
        
    }

    

    func createHabit(habit: Habit) {
        let habit = Habit(
            id: habit.id,
            title: title,
            emoji: selectedEmoji,
            current: habit.current,
            total: Double(targetAmount) ?? 100,
            colorHex: color.toHex() ?? "#FF0000",
            isCompleted: false,
            sound: "",
            category: selectedUnit,
            reminderTime: reminderTime,
            reminderDays: "Everyday",
            complatedDay: habit.complatedDay,
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




