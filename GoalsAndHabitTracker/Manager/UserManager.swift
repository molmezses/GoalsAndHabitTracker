//
//  UserManager.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 27.04.2025.
//
//Eğer daha önce bir userId kaydedilmediyse, UUID() üretiyor ve kaydediyor.
//Eğer zaten varsa, onu kullanıyor.

import Foundation

class UserManager{
    static let shared = UserManager()
    
    private let userIdKey = "userId"
    
    var userId: String? {
        if let id = UserDefaults.standard.string(forKey: userIdKey) {
            return id
        }
        else{
            let newId = UUID().uuidString
            UserDefaults.standard.set(newId , forKey: userIdKey)
            return newId
        }
    }
}
