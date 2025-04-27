//
//  GoalsAndHabitTrackerApp.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 22.04.2025.
//

import SwiftUI

@main
struct GoalsAndHabitTrackerApp: App {
    @StateObject private var habitVM = HabitViewModel() // HabitViewModel'i başlatıyoruz
    @StateObject private var addCustomHabitVM = AddCustomHabitViewModel() // AddCustomHabitViewModel'i başlatıyoruz

    var body: some Scene {
        WindowGroup {
            AddCustomHabitView()
                .environmentObject(habitVM) // HabitViewModel'i environmentObject olarak sağlıyoruz
                .environmentObject(addCustomHabitVM) // AddCustomHabitViewModel'i environmentObject olarak sağlıyoruz
        }
    }
}
