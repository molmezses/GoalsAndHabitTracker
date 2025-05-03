//
//  FirestoreManager.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 1.05.2025.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirestoreManager {
    static let shared = FirestoreManager()
    private init() {}

    private let db = Firestore.firestore()

    func setupUserSettings() {
        guard let userId = UserManager.shared.userId else { return }

        let settingsRef = db.collection("users")
                            .document(userId)
                            .collection("userSettings")
                            .document("settings")

        settingsRef.getDocument { (document, error) in
            if let document = document, document.exists {
                print("userSettings zaten mevcut.")
            } else {
                settingsRef.setData([
                    "habitStyle": 1
                ]) { error in
                    if let error = error {
                        print("userSettings oluşturulamadı: \(error.localizedDescription)")
                    } else {
                        print("userSettings başarıyla oluşturuldu.")
                    }
                }
            }
        }
    }
    
    func updateHabitStyle(_ habitStyle: Int) {
        guard let userId = UserManager.shared.userId else { return }

        let settingsRef = db.collection("users")
                            .document(userId)
                            .collection("userSettings")
                            .document("settings")

        settingsRef.updateData([
            "habitStyle": habitStyle
        ]) { error in
            if let error = error {
                print("habitStyle güncellenemedi: \(error.localizedDescription)")
            } else {
                print("habitStyle başarıyla güncellendi.")
            }
        }
    }
    
    func fetchHabitStyle(completion: @escaping (Int?) -> Void) {
        guard let userId = UserManager.shared.userId else {
            completion(nil)
            return
        }

        let settingsRef = db.collection("users")
                            .document(userId)
                            .collection("userSettings")
                            .document("settings")

        settingsRef.getDocument { (document, error) in
            if let document = document, document.exists,
               let data = document.data(),
               let habitStyle = data["habitStyle"] as? Int {
                completion(habitStyle)
            } else {
                completion(nil)
            }
        }
    }
    
    func deleteHabit(_ habit: Habit, completion: @escaping (Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
        
        guard let habitID = habit.id else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Habit ID bulunamadı."])))
            return
        }
        
        guard let userID = UserManager.shared.userId else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "User ID bulunamadı."])))
            return
        }

        let habitRef = db.collection("users")
            .document(userID)
            .collection("habits")
            .document(habitID)
        
        habitRef.delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }


}
