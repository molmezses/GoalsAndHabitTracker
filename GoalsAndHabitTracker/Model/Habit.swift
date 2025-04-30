//
//  Habit.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 22.04.2025.
//

import Foundation
import SwiftUI
import FirebaseFirestore




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
    var complatedDayCount: Int {
        return complatedDay.count
    }
    var complatedDay: [String]
    var missing: Int
    var longestSeries: Int
    var startingDay: String

    // colorHex'i kullanarak hesaplanan yardımcı alan
    var color: Color {
        Color(hex: colorHex)
    }
}


extension Habit{
    static var MOCK_HABIT: [Habit] = [
        Habit(title: "asdasd", emoji: "😁", current: 0, total: 0, colorHex: "324234", isCompleted: true, sound: "sdfsfd", category: "eda", reminderTime: Date(), reminderDays: "",  complatedDay: ["29 April 2025" , "12 April 2025"], missing: 0, longestSeries: 0, startingDay: ""),
        Habit(title: "asdasd", emoji: "😁", current: 0, total: 0, colorHex: "324234", isCompleted: true, sound: "sdfsfd", category: "eda", reminderTime: Date(), reminderDays: "",  complatedDay: ["29 April 2025" , "12 April 2025"], missing: 0, longestSeries: 0, startingDay: ""),
        Habit(title: "123123123", emoji: "😁", current: 0, total: 0, colorHex: "324234", isCompleted: true, sound: "sdfsfd", category: "eda", reminderTime: Date(), reminderDays: "",  complatedDay: ["29 April 2025" , "12 April 2025"], missing: 0, longestSeries: 0, startingDay: "")
    ]
}
