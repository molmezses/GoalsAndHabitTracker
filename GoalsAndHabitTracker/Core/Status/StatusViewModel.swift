//
//  StatusViewModel.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 29.04.2025.
//

import Foundation


class StatusViewModel: ObservableObject {
    
    // Üst üste en uzun seriyi hesapla
    func calculateLongestSeries(_ habit: Habit) -> Int {
        guard !habit.complatedDay.isEmpty else { return 0 }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US")
        
        // Tarihleri sırala
        let sortedDates = habit.complatedDay.compactMap { formatter.date(from: $0) }.sorted()
        
        guard !sortedDates.isEmpty else { return 0 }
        
        var longestStreak = 1
        var currentStreak = 1
        
        let calendar = Calendar.current
        
        for i in 1..<sortedDates.count {
            if let daysBetween = calendar.dateComponents([.day], from: sortedDates[i-1], to: sortedDates[i]).day {
                if daysBetween == 1 {
                    // Üst üste günler
                    currentStreak += 1
                    longestStreak = max(longestStreak, currentStreak)
                } else {
                    // Seri kırıldı
                    currentStreak = 1
                }
            }
        }
        
        return longestStreak
    }

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
    
    // Haftalık tamamlanma oranı
    func weeklyCompletionRate(_ habit: Habit) -> Double {
        let calendar = Calendar.current
        let today = Date()
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: today) ?? today
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US")
        
        let completedInWeek = habit.complatedDay.filter { dayString in
            guard let date = formatter.date(from: dayString) else { return false }
            return date >= weekAgo && date <= today
        }.count
        
        return Double(completedInWeek) / 7.0 * 100
    }
    
    // Ortalama günlük performans
    func averageDailyPerformance(_ habit: Habit) -> String {
        guard !habit.complatedDay.isEmpty else { return "0%" }
        guard !habit.startingDay.isEmpty else { return "0%" }
        
        // Starting day formatını kontrol et ve parse et
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        
        var startDate: Date?
        
        // Önce "d MMMM" formatını dene
        formatter.dateFormat = "d MMMM"
        startDate = formatter.date(from: habit.startingDay)
        
        // Eğer parse edilemezse, "d MMMM yyyy" formatını dene
        if startDate == nil {
            formatter.dateFormat = "d MMMM yyyy"
            startDate = formatter.date(from: habit.startingDay)
        }
        
        guard let parsedStartDate = startDate else {
            // Eğer hiç parse edilemezse, bugünden başlat
            let daysSinceStart = 1
            let completionRate = Double(habit.complatedDay.count) / Double(daysSinceStart) * 100
            return String(format: "%.1f%%", completionRate)
        }
        
        // Yılı ekle (mevcut yıl)
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        var startComponents = calendar.dateComponents([.day, .month], from: parsedStartDate)
        startComponents.year = currentYear
        
        guard let startDateWithYear = calendar.date(from: startComponents) else {
            return "0%"
        }
        
        let daysSinceStart = max(calendar.dateComponents([.day], from: startDateWithYear, to: Date()).day ?? 1, 1)
        let completionRate = Double(habit.complatedDay.count) / Double(daysSinceStart) * 100
        
        return String(format: "%.1f%%", completionRate)
    }
    
    // Bu hafta tamamlanan günler
    func thisWeekCompletedDays(_ habit: Habit) -> Int {
        let calendar = Calendar.current
        let today = Date()
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: today) ?? today
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US")
        
        return habit.complatedDay.filter { dayString in
            guard let date = formatter.date(from: dayString) else { return false }
            return date >= weekAgo && date <= today
        }.count
    }
    
    // Mevcut seri (bugüne kadar üst üste)
    func currentStreak(_ habit: Habit) -> Int {
        guard !habit.complatedDay.isEmpty else { return 0 }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US")
        
        let today = Date()
        let calendar = Calendar.current
        var streak = 0
        var checkDate = today
        var maxIterations = 365 // Sonsuz döngüyü önlemek için limit
        
        // Bugün tamamlandı mı kontrol et
        let todayString = formatter.string(from: today)
        if habit.complatedDay.contains(todayString) {
            streak = 1
            if let yesterday = calendar.date(byAdding: .day, value: -1, to: today) {
                checkDate = yesterday
            } else {
                return streak
            }
        } else {
            // Bugün tamamlanmadıysa dünü kontrol et
            if let yesterday = calendar.date(byAdding: .day, value: -1, to: today) {
                checkDate = yesterday
            } else {
                return 0
            }
        }
        
        // Geriye doğru kontrol et
        while maxIterations > 0 {
            let dateString = formatter.string(from: checkDate)
            if habit.complatedDay.contains(dateString) {
                streak += 1
                if let prevDay = calendar.date(byAdding: .day, value: -1, to: checkDate) {
                    checkDate = prevDay
                } else {
                    break
                }
            } else {
                break
            }
            maxIterations -= 1
        }
        
        return streak
    }

}


