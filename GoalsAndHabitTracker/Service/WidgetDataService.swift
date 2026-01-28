//
//  WidgetDataService.swift
//  GoalsAndHabitTracker
//
//  Widget için veri paylaşım servisi
//

import Foundation
import WidgetKit

class WidgetDataService {
    static let shared = WidgetDataService()
    
    // App Group identifier (Xcode'da App Group ekledikten sonra buraya ekleyin)
    // Format: "group.{bundle-identifier}"
    private let appGroupIdentifier = "group.com.olmezsesmustafa.GoalsAndHabitTracker"
    
    // UserDefaults key
    private let habitsKey = "widget_habits"
    
    private init() {}
    
    // Habit'leri widget için kaydet
    func saveHabitsForWidget(_ habits: [Habit]) {
        print("🔧 WidgetDataService: saveHabitsForWidget çağrıldı, \(habits.count) habit")
        print("🔧 WidgetDataService: App Group ID: \(appGroupIdentifier)")
        
        // Habit'leri dictionary array'e çevir (JSONSerialization ile uyumlu)
        let habitsArray = habits.map { habit -> [String: Any] in
            var dict: [String: Any] = [:]
            dict["id"] = habit.id ?? UUID().uuidString
            dict["title"] = habit.title
            dict["emoji"] = habit.emoji
            dict["current"] = habit.current
            dict["total"] = habit.total
            dict["colorHex"] = habit.colorHex
            dict["isCompleted"] = habit.isCompleted
            dict["countingMode"] = habit.countingMode.rawValue
            dict["timerElapsed"] = habit.timerElapsed
            dict["timerTarget"] = habit.timerTarget
            dict["reminderDays"] = habit.reminderDays
            return dict
        }
        
        print("🔧 WidgetDataService: \(habitsArray.count) habit dictionary'ye çevrildi")
        
        // JSONSerialization ile encode et (widget ile uyumlu)
        guard let jsonData = try? JSONSerialization.data(withJSONObject: habitsArray) else {
            print("❌ WidgetDataService: HATA - Habit'ler encode edilemedi!")
            return
        }
        
        print("🔧 WidgetDataService: JSON data oluşturuldu, boyut: \(jsonData.count) bytes")
        
        // App Group UserDefaults kullan (eğer App Group yoksa standart UserDefaults)
        if let sharedDefaults = UserDefaults(suiteName: appGroupIdentifier) {
            sharedDefaults.set(jsonData, forKey: habitsKey)
            sharedDefaults.synchronize() // Hemen senkronize et
            print("✅ WidgetDataService: \(habits.count) habit widget'a kaydedildi (App Group: \(appGroupIdentifier))")
            
            // Kontrol: Veriyi okuyup doğrula
            if let savedData = sharedDefaults.data(forKey: habitsKey) {
                print("✅ WidgetDataService: Veri doğrulandı, kaydedilen boyut: \(savedData.count) bytes")
                
                // Widget'ı yenile
                WidgetCenter.shared.reloadAllTimelines()
                print("🔄 WidgetDataService: Widget yenilendi")
            } else {
                print("❌ WidgetDataService: HATA - Veri kaydedilemedi!")
            }
        } else {
            // Fallback: Standart UserDefaults
            print("⚠️ WidgetDataService: App Group bulunamadı, standart UserDefaults kullanılıyor")
            UserDefaults.standard.set(jsonData, forKey: habitsKey)
            UserDefaults.standard.synchronize()
            print("✅ WidgetDataService: \(habits.count) habit widget'a kaydedildi (Standart UserDefaults)")
        }
    }
    
    // Widget'tan habit'leri oku
    func loadHabitsForWidget() -> [Habit] {
        var data: Data?
        
        // App Group UserDefaults'tan oku
        if let sharedDefaults = UserDefaults(suiteName: appGroupIdentifier) {
            data = sharedDefaults.data(forKey: habitsKey)
        } else {
            // Fallback: Standart UserDefaults
            data = UserDefaults.standard.data(forKey: habitsKey)
        }
        
        guard let data = data,
              let habits = try? JSONDecoder().decode([Habit].self, from: data) else {
            return []
        }
        
        return habits
    }
    
    // Bugünün habit'lerini filtrele
    func getTodayHabits() -> [Habit] {
        let allHabits = loadHabitsForWidget()
        let today = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: today)
        
        // Haftanın günü string'e çevir (1=Pazar, 2=Pazartesi, ...)
        let weekdayNames = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        let todayName = weekdayNames[weekday - 1]
        
        return allHabits.filter { habit in
            // Reminder days string'inde bugünün günü var mı kontrol et
            habit.reminderDays.contains(todayName)
        }
    }
}
