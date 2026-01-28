//
//  StatusViewRedesigned.swift
//  GoalsAndHabitTracker
//
//  Redesigned professional StatusView
//

import SwiftUI

struct StatusViewRedesigned: View {
    @EnvironmentObject var viewModel: StatusViewModel
    @Environment(\.dismiss) var dismiss
    @State var currentMonth: Int = Calendar.current.component(.month, from: Date())
    @State var currentYear: Int = Calendar.current.component(.year, from: Date())
    @State var animate: Bool = false
    let habit: Habit
    
    let daysOfWeek: [String] = ["S", "M", "T", "W", "T", "F", "S"]
    let daysOfWeekColumns = Array(repeating: GridItem(.flexible()), count: 7)
    let weekIndices: [Int] = [0, 1, 2, 3, 4, 5, 6]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea(edges: .bottom)
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Header Section (with back button, emoji, and habit info)
                        headerSection
                        
                        // Calendar Section (moved to top)
                        calendarSection
                        
                        // Stats Cards Grid (moved below calendar)
                        statsGridSection
                        
                        // Weekly Progress Chart
                        weeklyProgressSection
                        
                        // Additional Stats
                        additionalStatsSection
                    }
                    .padding(.bottom, 20)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    EmptyView()
                }
            }
        }
    }
    
    // MARK: - Header Section
    var headerSection: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                // Back Button
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(width: 40, height: 40)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(Circle())
                }
                
                // Emoji
                Text(habit.emoji)
                    .font(.system(size: 50))
                
                // Habit Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(habit.title)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                    
                    Text(habit.category)
                        .font(.system(size: 14, design: .rounded))
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                Color(.systemBackground)
                    .ignoresSafeArea(edges: .top)
            )
        }
        .opacity(animate ? 1 : 0)
        .offset(y: animate ? 0 : -20)
        .animation(.easeOut(duration: 0.6), value: animate)
        .onAppear {
            animate = true
        }
    }
    
    // MARK: - Stats Grid
    var statsGridSection: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                StatCard(
                    title: "\(habit.complatedDayCount)",
                    subtitle: "Completed",
                    icon: "checkmark.circle.fill",
                    color: .green,
                    gradient: [.green, .green.opacity(0.7)]
                )
                
                StatCard(
                    title: "\(viewModel.calculateLongestSeries(habit))",
                    subtitle: "Longest Streak",
                    icon: "flame.fill",
                    color: .orange,
                    gradient: [.orange, .orange.opacity(0.7)]
                )
            }
            
            HStack(spacing: 12) {
                StatCard(
                    title: "\(viewModel.currentStreak(habit))",
                    subtitle: "Current Streak",
                    icon: "bolt.fill",
                    color: .yellow,
                    gradient: [.yellow, .yellow.opacity(0.7)]
                )
                
                StatCard(
                    title: viewModel.currentMonthCompletionPercentage(habit),
                    subtitle: "This Month",
                    icon: "calendar",
                    color: .purple,
                    gradient: [.purple, .purple.opacity(0.7)]
                )
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - Calendar Section
    var calendarSection: some View {
        VStack(spacing: 16) {
            // Month Navigation
            HStack {
                Button {
                    leftButtonClicked()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(habit.color)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                VStack(spacing: 4) {
                    Text(formattedMonthYear(month: currentMonth, year: currentYear))
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("\(currentYear)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button {
                    rightButtonClicked()
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(habit.color)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
            }
            .padding(.horizontal)
            
            // Calendar Grid
            VStack(spacing: 12) {
                // Weekday Headers
                HStack(spacing: 0) {
                    ForEach(daysOfWeek, id: \.self) { day in
                        Text(day)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                // Days
                LazyVGrid(columns: daysOfWeekColumns, spacing: 8) {
                    ForEach(generateCalendarDays(), id: \.self) { day in
                        CalendarDayView(
                            day: day,
                            habit: habit,
                            currentMonth: currentMonth,
                            currentYear: currentYear,
                            viewModel: viewModel
                        )
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
            )
        }
        .padding(.horizontal)
    }
    
    // MARK: - Weekly Progress
    var weeklyProgressSection: some View {
        // DateFormatter'ı loop dışına aldık (performans + hata önleme)
        let dayFormatter: DateFormatter = {
            let f = DateFormatter()
            f.dateFormat = "d MMMM yyyy"
            f.locale = Locale(identifier: "en_US")
            return f
        }()

        return VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Weekly Progress")
                    .font(.title3)
                    .fontWeight(.bold)

                Spacer()

                Text("\(viewModel.thisWeekCompletedDays(habit))/7 days")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            // Simple Bar Chart
            HStack(alignment: .bottom, spacing: 8) {
                ForEach(weekIndices, id: \.self) { index in
                    let dayOffset = -(6 - index)
                    let dayAgo = Calendar.current.date(byAdding: .day, value: dayOffset, to: Date()) ?? Date()

                    let dayString = dayFormatter.string(from: dayAgo)
                    let isCompleted = habit.complatedDay.contains(dayString)

                    VStack(spacing: 4) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(isCompleted ? habit.color : Color.gray.opacity(0.2))
                            .frame(height: isCompleted ? 60 : 20)
                            .animation(
                                .spring(response: 0.4, dampingFraction: 0.7),
                                value: isCompleted
                            )

                        // crash önleme
                        Text(daysOfWeek.indices.contains(index) ? daysOfWeek[index] : "")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(height: 80)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal)
    }

    
    // MARK: - Additional Stats
    var additionalStatsSection: some View {
        VStack(spacing: 12) {
            AdditionalStatRow(
                icon: "chart.line.uptrend.xyaxis",
                title: "Average Performance",
                value: viewModel.averageDailyPerformance(habit),
                color: .blue
            )
            
            AdditionalStatRow(
                icon: "clock.badge.checkmark",
                title: "Reminder Time",
                value: viewModel.dateFormatHours(habit.reminderTime),
                color: .mint
            )
            
            AdditionalStatRow(
                icon: "calendar.badge.clock",
                title: "Started",
                value: habit.startingDay.isEmpty ? "N/A" : habit.startingDay,
                color: .orange
            )
            
            AdditionalStatRow(
                icon: "xmark.circle.fill",
                title: "Missing Days",
                value: "\(habit.missing)",
                color: .red
            )
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal)
    }
    
    // Helper Functions
    func formattedMonthYear(month: Int, year: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        var components = DateComponents()
        components.year = year
        components.month = month
        if let date = Calendar.current.date(from: components) {
            return dateFormatter.string(from: date)
        }
        return "Invalid"
    }
    
    func generateCalendarDays() -> [CalendarDay] {
        let calendar = Calendar.current
        let firstDayOfMonth = DateComponents(year: currentYear, month: currentMonth, day: 1)
        
        guard let firstDate = calendar.date(from: firstDayOfMonth),
              let daysRange = calendar.range(of: .day, in: .month, for: firstDate) else {
            return []
        }
        
        let numberOfDays = daysRange.count
        let firstWeekday = calendar.component(.weekday, from: firstDate) - 1
        
        var days: [CalendarDay] = []
        
        let prevMonth = currentMonth == 1 ? 12 : currentMonth - 1
        let prevYear = currentMonth == 1 ? currentYear - 1 : currentYear
        let prevMonthDays = numberOfDaysInMonth(month: prevMonth, year: prevYear)
        
        if firstWeekday > 0 {
            for i in (prevMonthDays - firstWeekday + 1)...prevMonthDays {
                days.append(CalendarDay(day: i, isCurrentMonth: false))
            }
        }
        
        for i in 1...numberOfDays {
            days.append(CalendarDay(day: i, isCurrentMonth: true))
        }
        
        let remainingDays = 42 - days.count
        if remainingDays > 0 {
            for i in 1...remainingDays {
                days.append(CalendarDay(day: i, isCurrentMonth: false))
            }
        }
        return days
    }
    
    func numberOfDaysInMonth(month: Int, year: Int) -> Int {
        var components = DateComponents()
        components.year = year
        components.month = month
        if let date = Calendar.current.date(from: components),
           let range = Calendar.current.range(of: .day, in: .month, for: date) {
            return range.count
        }
        return 0
    }
    
    func leftButtonClicked() {
        withAnimation(.spring) {
            if currentMonth == 1 {
                currentMonth = 12
                currentYear -= 1
            } else {
                currentMonth -= 1
            }
        }
    }
    
    func rightButtonClicked() {
        withAnimation(.spring) {
            if currentMonth == 12 {
                currentMonth = 1
                currentYear += 1
            } else {
                currentMonth += 1
            }
        }
    }
}

// MARK: - Supporting Views
struct StatCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let gradient: [Color]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(
                        LinearGradient(colors: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .clipShape(Circle())
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        )
    }
}

struct CalendarDayView: View {
    let day: CalendarDay
    let habit: Habit
    let currentMonth: Int
    let currentYear: Int
    let viewModel: StatusViewModel
    
    var body: some View {
        let formattedDate = formattedFullDate(day: day.day, month: currentMonth, year: currentYear)
        let isCompleted = day.isCurrentMonth && habit.complatedDay.contains(formattedDate)
        let isToday = viewModel.isToday(day: day, currentMonth: currentMonth, currentYear: currentYear)
        
        ZStack {
            if isCompleted {
                Circle()
                    .fill(habit.color)
            } else if day.isCurrentMonth {
                Circle()
                    .fill(habit.color.opacity(0.1))
            }
            
            VStack(spacing: 2) {
                Text("\(day.day)")
                    .font(.system(size: 14, weight: isCompleted ? .bold : .regular))
                    .foregroundColor(isCompleted ? .white : (day.isCurrentMonth ? .primary : .secondary))
                
                if isToday {
                    Circle()
                        .fill(.red)
                        .frame(width: 4, height: 4)
                }
            }
        }
        .frame(width: 40, height: 40)
    }
    
    func formattedFullDate(day: Int, month: Int, year: Int) -> String {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US")
        if let date = calendar.date(from: components) {
            return formatter.string(from: date)
        }
        return ""
    }
}

struct AdditionalStatRow: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
                .frame(width: 40, height: 40)
                .background(color.opacity(0.1))
                .clipShape(Circle())
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .font(.headline)
                .fontWeight(.semibold)
        }
        .padding(.vertical, 8)
    }
}
