//
//  HomeViewViewModel.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 27.04.2025.
//

import SwiftUI
import Foundation

class HomeViewViewModel: ObservableObject {
    

    @Published  var showAddView = false
    
    func openAddHabitView(){
        showAddView = true
    }
    
    func todayCalendarToStringHeader() -> String {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd, MMMM"
        let formattedDate = formatter.string(from: today)
        return formattedDate
    }

       
    
}
