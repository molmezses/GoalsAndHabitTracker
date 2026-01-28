//
//  HabitBarSettingsViewModel.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 24.04.2025.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import Firebase
import UIKit


enum habitBarStyle: Int {
    case barstyle1 = 1  // Default - Simple
    case barstyle2 = 2  // Progress Bar Fill
    case barstyle3 = 3  // Progress Bar Thin
    case barstyle4 = 4  // Border with Progress
    case barstyle5 = 5  // Thin Side Bar
    case barstyle6 = 6  // Border Only
    case barstyle7 = 7  // Card with Shadow
    case barstyle8 = 8  // Gradient Progress
    case barstyle9 = 9  // Compact Minimal
}

class HabitBarSettingsViewModel: ObservableObject {
    @Published var barStyle: habitBarStyle = .barstyle1 {
        didSet {
            FirestoreManager.sharedFirestoreManager.updateHabitStyle(barStyle.rawValue)
        }
    }

    init() {
        loadBarStyleFromFirestore()
    }

    private func loadBarStyleFromFirestore() {
        FirestoreManager.sharedFirestoreManager.fetchHabitStyle { [weak self] styleValue in
            DispatchQueue.main.async {
                if let value = styleValue, let style = habitBarStyle(rawValue: value) {
                    self?.barStyle = style
                }
            }
        }
    }
    


}

