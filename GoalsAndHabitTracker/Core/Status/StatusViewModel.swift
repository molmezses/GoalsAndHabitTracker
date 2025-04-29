//
//  StatusViewModel.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 29.04.2025.
//

import Foundation


class StatusViewModel: ObservableObject {
    func dateFormatHours(_ date: Date?) -> String {
        guard let date = date else { return "--:--" }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

}


