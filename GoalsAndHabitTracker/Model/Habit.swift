//
//  Habit.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 22.04.2025.
//

import Foundation
import SwiftUI


struct Habit: Identifiable , Hashable {
    let id: String
    let title: String
    let emoji: String
    var current: Double
    var total: Double
    let color: Color
    let isCompleted: Bool
    let sound: String
    let category: String
    let reminderTime : Date
    let reminderDays: String
    let complatedDayCount: Int
    let complatedDay: [String]
    let missing: Int
    let longestSeries: Int
    let startingDay: String
    
}

extension Habit{
    static var MOCK_HABIT: [Habit] = [
        .init(id: UUID().uuidString, title: "Drink a water", emoji: "💧", current: 60, total: 500, color: .blue, isCompleted: false, sound: "default", category: "health", reminderTime: Date(), reminderDays: "everyday", complatedDayCount: 9, complatedDay: ["1 April 2025", "4 April 2025", "7 April 2025", "10 April 2025", "13 April 2025","17 April 2025", "20 April 2025", "24 April 2025", "27 April 2025", "30 April 2025",], missing: 6, longestSeries: 12, startingDay: "21 Sep 25"),
        .init(id: UUID().uuidString, title: "Read a Book", emoji: "📚", current: 35, total: 50, color: .green, isCompleted: false, sound: "default", category: "health", reminderTime: Date(), reminderDays: "everyday", complatedDayCount: 9, complatedDay: ["1 April 2025", "4 April 2025", "7 April 2025", "10 April 2025", "14 April 2025","17 April 2025", "20 April 2025", "24 April 2025", "27 April 2025", "30 April 2025",], missing: 6, longestSeries: 12, startingDay: "21 Sep 25"),
        .init(id: UUID().uuidString, title: "Gym", emoji: "💪🏻", current: 20, total: 55, color: .orange, isCompleted: true, sound: "default", category: "health", reminderTime: Date(), reminderDays: "everyday", complatedDayCount: 9, complatedDay: ["1 April 2025", "4 April 2025", "7 April 2025", "10 April 2025", "14 April 2025","17 April 2025", "20 April 2025", "24 April 2025", "27 April 2025", "30 April 2025",], missing: 6, longestSeries: 12, startingDay: "21 Sep 25"),
        .init(id: UUID().uuidString, title: "Watering the flowers", emoji: "🌺", current: 5, total: 5, color: .pink, isCompleted: true, sound: "default", category: "health", reminderTime: Date() ,reminderDays: "everyday", complatedDayCount: 9, complatedDay: ["1 April 2025", "4 April 2025", "7 April 2025", "10 April 2025", "14 April 2025","17 April 2025", "20 April 2025", "24 April 2025", "27 April 2025", "30 April 2025",], missing: 6, longestSeries: 12, startingDay: "21 Sep 25"),
        .init(id: UUID().uuidString, title: "Give to foot the cat", emoji: "🐈", current: 1, total: 2, color: .indigo, isCompleted: false, sound: "default", category: "health", reminderTime: Date(), reminderDays: "everyday", complatedDayCount: 9, complatedDay: ["1 April 2025", "4 April 2025", "7 April 2025", "10 April 2025", "14 April 2025","17 April 2025", "20 April 2025", "24 April 2025", "27 April 2025", "30 April 2025",], missing: 6, longestSeries: 12, startingDay: "21 Sep 25"),
    ]
}
