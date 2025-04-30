//
//  StatusViewModel.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 29.04.2025.
//

import Foundation


class StatusViewModel: ObservableObject {

    func currentMonthCompletionPercentage(_ habit: Habit) -> String {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let currentYear = calendar.component(.year, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        
        // Bu ay toplam kaç gün var
        guard let range = calendar.range(of: .day, in: .month, for: currentDate) else { return "0%" }
        let totalDaysInMonth = range.count
        
        // Formatter: "12 April 2025"
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US") // İngilizce ay isimleri
        
        // Sadece bu aya ve yıla ait tamamlanan günleri filtrele
        let completedInCurrentMonth = habit.complatedDay.filter { dayString in
            guard let date = formatter.date(from: dayString) else { return false }
            let month = calendar.component(.month, from: date)
            let year = calendar.component(.year, from: date)
            return month == currentMonth && year == currentYear
        }.count
        
        // Yüzde hesapla
        let percentage = Double(completedInCurrentMonth) / Double(totalDaysInMonth) * 100
        return String(format: "%.0f%%", percentage)
    }
    
    func isToday(day: CalendarDay, currentMonth: Int, currentYear: Int) -> Bool {
        let today = Calendar.current.dateComponents([.day, .month, .year], from: Date())
        return day.day == today.day &&
               currentMonth == today.month &&
               currentYear == today.year &&
               day.isCurrentMonth
    }



    
    
    
    
    
    
    
    
    func dateFormatHours(_ date: Date?) -> String {
        guard let date = date else { return "--:--" }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

}


