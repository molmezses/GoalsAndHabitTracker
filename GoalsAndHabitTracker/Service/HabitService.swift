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
    
    func updateHabit(_ habit: Habit)  async throws {
        guard let habitId = habit.id else {
            throw NSError(domain: "HATA : Böyle bir habit bulanumadı", code: -1)
        }
        
        try  db.collection("users")
            .document(userId)
            .collection("habits")
            .document(habitId)
            .setData(from: habit, merge: true) //Merge true yazılmasıının sebebi sadece değişen veriler güncellenecek belgeler sıfırlanmayacak
        
    }
    
    func resetHabitsIfNewDay(_ habits: [Habit]) async {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        for var habit in habits {
            let lastUpdate = habit.lastUpdated ?? Date.distantPast
            let lastUpdateDay = calendar.startOfDay(for: lastUpdate)

            // Eğer bugünle aynı değilse (yeni güne geçilmişse)
            if lastUpdateDay < today {
                // Moda göre reset
                switch habit.countingMode {
                case .forward:
                    habit.current = 0
                case .backward:
                    habit.current = habit.total
                case .timer:
                    habit.timerElapsed = 0
                    habit.isTimerRunning = false
                }
                habit.lastUpdated = Date()

                do {
                    try await updateHabit(habit)
                    print("Habit resetlendi: \(habit.title)")
                } catch {
                    print("Resetleme hatası: \(error.localizedDescription)")
                }
            }
        }
    }

    
    
}







