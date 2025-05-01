//
//  GoalsAndHabitTrackerApp.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 22.04.2025.
//

import SwiftUI
import Firebase
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        // Firebase yapılandırmasından sonra Firestore işlemleri başlatılabilir
        FirestoreManager.shared.setupUserSettings()
        
        return true
    }
}


@main
struct GoalsAndHabitTrackerApp: App {
    @StateObject private var addCustomHabitVM = AddCustomHabitViewModel()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(addCustomHabitVM)
                .environmentObject(HabitBarSettingsViewModel())
                .environmentObject(StatusViewModel())
                .environmentObject(ProgressViewModel())
                .environmentObject(UpdateViewModel())
        }
    }
}

