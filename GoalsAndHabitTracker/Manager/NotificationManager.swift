//
//  NotificationManager.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 2.05.2025.
//

import Foundation
import UserNotifications

class NotificationManager{
    
    static let instance = NotificationManager()
    
    func requestAuthorization(){
        
        let options = UNAuthorizationOptions([.alert, .badge, .sound])
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error{
                print("\(error.localizedDescription)")
            }else{
                print("success")
            }
        }
        
    }
    
    func scheduleNotification(hour: Int , minute: Int , title: String , subtitle: String , identifier: String , sound: String){
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.badge = 1
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "\(sound).caf"))
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    

    
}
