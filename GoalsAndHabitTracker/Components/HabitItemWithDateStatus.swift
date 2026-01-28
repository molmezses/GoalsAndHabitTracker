//
//  HabitItemWithDateStatus.swift
//  GoalsAndHabitTracker
//
//  HabitItem with date status indicator
//

import SwiftUI

struct HabitItemWithDateStatus: View {
    let habit: Habit
    let selectedDate: Date?
    let isCompleted: Bool?
    
    @EnvironmentObject var viewModel: HabitBarSettingsViewModel
    
    var body: some View {
        ZStack(alignment: .trailing) {
            HabitItem(habit: habit)
            
            // Date Status Badge
            if let selectedDate = selectedDate, let isCompleted = isCompleted {
                VStack {
                    HStack {
                        Spacer()
                        
                        HStack(spacing: 6) {
                            Image(systemName: isCompleted ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundColor(isCompleted ? .green : .red.opacity(0.6))
                                .font(.title3)
                            
                            Text(dateStatusText(for: selectedDate))
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(isCompleted ? .green : .secondary)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(isCompleted ? Color.green.opacity(0.1) : Color(.systemGray6))
                        )
                    }
                    
                    Spacer()
                }
                .padding(.trailing, 12)
                .padding(.top, 8)
            }
        }
    }
    
    private func dateStatusText(for date: Date) -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else if calendar.isDateInTomorrow(date) {
            return "Tomorrow"
        } else if date < Date() {
            return "Past"
        } else {
            return "Future"
        }
    }
}
