//
//  ProgressViewModel.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 28.04.2025.
//

import Foundation
import Firebase
import FirebaseFirestore

class ProgressViewModel: ObservableObject {
    
    
    func formattedTodayDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: Date())
    }
    
    
//    Eğer habit bir struct türünde ise ve bu struct içinde diziyi değiştirmeye çalışıyorsanız, struct'ın fonksiyonunu mutating olarak işaretlemeniz gerekir. Aksi takdirde, bu türdeki veri yapıları değiştirilemez.

    func fetchCompletedDay(habit: inout Habit) {
        
        let today = formattedTodayDate()
        
        for day in habit.complatedDay {
            if let index = habit.complatedDay.firstIndex(of: today){
                habit.complatedDay.remove(at: index)
            }
        }
    }


}
