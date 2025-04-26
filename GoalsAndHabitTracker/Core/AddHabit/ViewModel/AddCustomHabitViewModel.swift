//
//  AddCustomHabitViewModel.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 25.04.2025.
//

import SwiftUI
import Foundation

// Color Extension to handle hex
extension Color {
    init(hex: String) {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hexString)
        var hexValue: UInt64 = 0
        scanner.scanHexInt64(&hexValue)
        
        let red = Double((hexValue & 0xFF0000) >> 16) / 255.0
        let green = Double((hexValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(hexValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

class AddCustomHabitViewModel: ObservableObject {

    @Published var animate: Bool = false
    @Published var color: Color = Color(hex: "#2980B9")
    @Published var title: String = ""
    @Published var selectedUnit: String = "Seç"
    @Published var targetAmount: String = ""
    @Published var selectedDays: Set<String> = []
    @Published var reminderTime = Date()
    @Published var reminderIsOn: Bool = true
    @Published var rapor: Bool = true
    @Published var selectedEmoji: String = "👑"
    @Published var showingEmojiSheet: Bool = false
    @Published var showingColorSheet: Bool = false
    @Published var complatedDay: Bool = false
    @Published var complatedDayCount: Int = 0
    @Published var complatedDays: [String] = []
    @Published var missing: Int = 0
    @Published var longestSeries: Int = 0
    @Published var startingDay: String = ""
    @Published var weekdays:[String] = ["PTS", "SAR", "ÇAR", "PER", "CUM", "CTS","PZT"]

}


