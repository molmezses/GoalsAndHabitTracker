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
    case barstyle1 = 1
    case barstyle2 = 2
    case barstyle3 = 3
    case barstyle4 = 4
    case barstyle5 = 5
    case barstyle6 = 6
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

