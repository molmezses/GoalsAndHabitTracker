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
    @Published var weekdays: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    @Published var selectedDays: Set<String> = []
    @Published var animate: Bool = false
    @Published var missing: Int = 0
    @Published var longestSeries: Int = 0
    @Published var rapor: Bool = false
    @Published var startingDay:String = ""
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
        current = 90
        startingDay = habit.startingDay
        missing = habit.missing
        longestSeries = habit.longestSeries
        
    }

    

    func createHabit(habit: Habit, soundVM : SoundViewModel) {
        let habit = Habit(
            id: habit.id,
            title: title,
            emoji: selectedEmoji,
            current: 80,
            total: Double(targetAmount) ?? 100,
            colorHex: color.toHex() ?? "#FF0000",
            isCompleted: false,
            sound: soundVM.soundBar.rawValue,
            category: selectedUnit,
            reminderTime: reminderTime,
            reminderDays: "Everyday",
            reminderMessage: reminderMessage,
            complatedDay: habit.complatedDay,
            missing: missing,
            longestSeries: longestSeries,
            startingDay: startingDay
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




