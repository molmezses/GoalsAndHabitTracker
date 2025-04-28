//
//  HabitService.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 27.04.2025.
//

import Foundation
import Firebase
import FirebaseFirestore


class HabitService {
    private let db = Firestore.firestore()
    private var userId: String {
        UserManager.shared.userId ?? "hata"
    }

    func addHabit(_ habit: Habit) async throws {
        try db.collection("users")
            .document(userId)
            .collection("habits")
            .document(habit.id ?? "hata")
            .setData(from: habit)
    }

    func listenHabits() -> AsyncStream<[Habit]> {
        let query = db.collection("users").document(userId).collection("habits")

        return AsyncStream { continuation in
            let listener = query.addSnapshotListener { snapshot, error in
                if let documents = snapshot?.documents {
                    let habits = documents.compactMap { try? $0.data(as: Habit.self) }
                    continuation.yield(habits)
                } else if let error = error {
                    print("Error listening to habits: \(error.localizedDescription)")
                }
            }

            continuation.onTermination = { @Sendable _ in
                listener.remove()
            }
        }
    }
}

