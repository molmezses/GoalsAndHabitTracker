//
//  AddCustomHabitViewModel.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 25.04.2025.
//

import SwiftUI
import Foundation


class AddCustomHabitViewModel: ObservableObject {
        
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
    @Published var colors: [Color] = [.red, .green, .blue, .yellow, .orange]
    
    @Published var habits: [Habit] = []

    

    func createHabit() {
        let habit = Habit(id: UUID().uuidString, title: title, emoji: selectedEmoji, current: 78, total: Double(targetAmount) ?? 100, color: color, isCompleted: false, sound: "", category: selectedUnit, reminderTime: reminderTime, reminderDays: "Everyday", complatedDayCount: 0, complatedDay: ["27 April 2025"], missing: 0, longestSeries: 0, startingDay: "23 Sep 2025")
        
        habits.append(habit)
        
        
        
    }
}




