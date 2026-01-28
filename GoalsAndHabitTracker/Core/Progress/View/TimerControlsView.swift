//
//  TimerControlsView.swift
//  GoalsAndHabitTracker
//
//  Created for timer mode controls
//

import SwiftUI

struct TimerControlsView: View {
    @Binding var habit: Habit
    var updateHabit: (Habit) -> Void
    var viewModel: ProgressViewModel
    
    @State private var timer: Timer?
    @State private var startTime: Date?
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 20) {
                // Start/Pause Button
                Button {
                    if habit.isTimerRunning {
                        pauseTimer()
                    } else {
                        startTimer()
                    }
                } label: {
                    Image(systemName: habit.isTimerRunning ? "pause.fill" : "play.fill")
                        .imageScale(.large)
                        .bold()
                        .padding()
                        .foregroundStyle(.white)
                        .background(habit.color)
                        .mask(Circle())
                }
                
                // Stop/Reset Button
                Button {
                    stopTimer()
                } label: {
                    Image(systemName: "stop.fill")
                        .imageScale(.large)
                        .bold()
                        .padding()
                        .foregroundStyle(.white)
                        .background(Color.red)
                        .mask(Circle())
                }
            }
            
            // Quick Add Buttons
            HStack(spacing: 12) {
                Button {
                    addTime(seconds: 60) // 1 minute
                } label: {
                    Text("+1m")
                        .font(.caption)
                        .padding(8)
                        .background(Color(.systemGroupedBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                Button {
                    addTime(seconds: 300) // 5 minutes
                } label: {
                    Text("+5m")
                        .font(.caption)
                        .padding(8)
                        .background(Color(.systemGroupedBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                Button {
                    addTime(seconds: 600) // 10 minutes
                } label: {
                    Text("+10m")
                        .font(.caption)
                        .padding(8)
                        .background(Color(.systemGroupedBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                Button {
                    addTime(seconds: 1800) // 30 minutes
                } label: {
                    Text("+30m")
                        .font(.caption)
                        .padding(8)
                        .background(Color(.systemGroupedBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        .onDisappear {
            pauseTimer()
        }
    }
    
    private func startTimer() {
        habit.isTimerRunning = true
        startTime = Date()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if let start = startTime {
                let elapsed = Date().timeIntervalSince(start)
                let newElapsed = habit.timerElapsed + elapsed
                
                // Update only once per second
                if Int(newElapsed) > Int(habit.timerElapsed) {
                    habit.timerElapsed = newElapsed
                    startTime = Date() // Reset start time
                    
                    // Check if target reached
                    if habit.timerTarget > 0 && habit.timerElapsed >= habit.timerTarget {
                        pauseTimer()
                        let date = viewModel.formattedTodayDate()
                        let wasAlreadyCompleted = habit.complatedDay.contains(date)
                        if !habit.complatedDay.contains(date) {
                            habit.complatedDay.append(date)
                        }
                        
                        // Celebration tetikle
                        if !wasAlreadyCompleted {
                            viewModel.triggerCelebration(habit: habit)
                        }
                    }
                    
                    habit.lastUpdated = Date()
                    viewModel.updateLongestSeries(habit: &habit)
                    habit.missing = viewModel.calcMissingDay(habit: habit)
                    updateHabit(habit)
                }
            }
        }
    }
    
    private func pauseTimer() {
        habit.isTimerRunning = false
        timer?.invalidate()
        timer = nil
        startTime = nil
        habit.lastUpdated = Date()
        updateHabit(habit)
    }
    
    private func stopTimer() {
        pauseTimer()
        habit.timerElapsed = 0
        habit.lastUpdated = Date()
        updateHabit(habit)
    }
    
    private func addTime(seconds: Double) {
        habit.timerElapsed += seconds
        
        // Check if target reached
        if habit.timerTarget > 0 && habit.timerElapsed >= habit.timerTarget {
            let date = viewModel.formattedTodayDate()
            let wasAlreadyCompleted = habit.complatedDay.contains(date)
            if !habit.complatedDay.contains(date) {
                habit.complatedDay.append(date)
            }
            
            // Celebration tetikle
            if !wasAlreadyCompleted {
                viewModel.triggerCelebration(habit: habit)
            }
        }
        
        habit.lastUpdated = Date()
        viewModel.updateLongestSeries(habit: &habit)
        habit.missing = viewModel.calcMissingDay(habit: habit)
        updateHabit(habit)
    }
}
