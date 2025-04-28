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
    @DocumentID var id: String? // Firestore'daki document id
    var title: String
    var emoji: String
    var current: Double
    var total: Double
    var colorHex: String // <-- BU VAR
    var isCompleted: Bool
    var sound: String
    var category: String
    var reminderTime: Date
    var reminderDays: String
    var complatedDayCount: Int
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
        Habit(title: "sddsf", emoji: "😁", current: 0, total: 0, colorHex: "324234", isCompleted: true, sound: "sdfsfd", category: "eda", reminderTime: Date(), reminderDays: "", complatedDayCount: 23, complatedDay: [""], missing: 0, longestSeries: 0, startingDay: "")
    ]
}
