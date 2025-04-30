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
    
    
    func disableButton(habit: Habit) -> Bool {
        if habit.current == habit.total {
            return true
        }
        return false
    }
    
    
    func formattedTodayDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: Date())
    }
    
    
//    Eğer habit bir struct türünde ise ve bu struct içinde diziyi değiştirmeye çalışıyorsanız, struct'ın fonksiyonunu mutating olarak işaretlemeniz gerekir. Aksi takdirde, bu türdeki veri yapıları değiştirilemez.

    func fetchCompletedDayAndRemove(habit: inout Habit) {
        
        let today = formattedTodayDate()
        
        for _ in habit.complatedDay {
            if let index = habit.complatedDay.firstIndex(of: today){
                habit.complatedDay.remove(at: index)
            }
        }
    }
    
    func daysBetweenTodayAnd(start: String) -> Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US")

        // Bugünün yılını al ve start stringine ekle (örneğin: "12 April" + " 2025")
        let currentYear = Calendar.current.component(.year, from: Date())
        let startWithYear = "\(start) \(currentYear)"

        guard let startDate = formatter.date(from: startWithYear) else {
            print("Tarih formatı hatalı.")
            return nil
        }

        let endDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        return components.day
    }
    
    func calcMissingDay(habit: Habit) -> Int{
        let missingDay = Int(daysBetweenTodayAnd(start: habit.startingDay) ?? 0) - Int(habit.complatedDay.count)
        
        if missingDay == 0 {
            return 0
        }
        return missingDay
    }




}
