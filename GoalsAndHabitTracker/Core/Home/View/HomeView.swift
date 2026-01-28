//
//  HomeView.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 22.04.2025.
//

import SwiftUI

struct HomeView: View {
    @State var animate: Bool = false
    @EnvironmentObject var viewModel: HabitBarSettingsViewModel
    @EnvironmentObject var habitViewModel: AddCustomHabitViewModel
    @EnvironmentObject var soundVM: SoundViewModel
    @State var animate2: Bool = false
    @StateObject var homeViewModel = HomeViewViewModel()
    @State private var searchText: String = ""
    @State private var showSearchBar: Bool = false
    @State private var selectedDate: Date? = nil



    

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                
                if habitViewModel.habits.isEmpty {
                    NoHabitView(
                        onAddTapped: {
                            homeViewModel.openAddHabitView()
                        }
                    )
                }
                VStack(spacing: 0) {
                    
                    HomeViewHeaderView
                    
                    // Search Bar
                    if showSearchBar {
                        SearchBarView(searchText: $searchText)
                            .padding(.horizontal)
                            .padding(.top, 8)
                            .transition(.move(edge: .top))
                    }

                    // Calendar
                    HorizontalCalendarView(selectedDate: $selectedDate)
                        .padding(.vertical)
                    
                    // Selected Date Info
                    if let selectedDate = selectedDate {
                        VStack(spacing: 8) {
                            HStack {
                                Image(systemName: "calendar")
                                    .foregroundColor(.mint)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(formatDateForHabit(selectedDate))
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                    
                                    Text(dateSubtitle(for: selectedDate))
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Button {
                                    self.selectedDate = nil
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.secondary)
                                }
                            }
                            
                            // Stats for selected date
                            let completedCount = habitViewModel.habits.filter { isHabitCompletedOnDate($0, date: selectedDate) }.count
                            let totalCount = habitViewModel.habits.count
                            
                            HStack {
                                HStack(spacing: 4) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                        .font(.caption)
                                    Text("\(completedCount) completed")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                HStack(spacing: 4) {
                                    Image(systemName: "list.bullet")
                                        .foregroundColor(.blue)
                                        .font(.caption)
                                    Text("\(totalCount) total")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.systemBackground))
                                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                        )
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.gray.opacity(0.1))
                        .shadow(color: .gray, radius: 4, x: 0, y: 2)
                    

                    // Scrollable Content
                    ZStack {
                        ScrollView {
                            VStack {
                                
                                
                                ForEach(filteredHabits) { habit in
                                    let update: (Habit) -> Void = { updatedHabit in
                                        Task {
                                            do {
                                                try await HabitService().updateHabit(updatedHabit)
                                            } catch {
                                                print("HATA: Firestore güncelleme hatası \(error.localizedDescription)")
                                            }
                                        }
                                    }
                                    
                                    let isCompletedOnSelectedDate = selectedDate != nil ? isHabitCompletedOnDate(habit, date: selectedDate!) : nil

                                    NavigationLink {
                                        ProgressView(habit: habit, updateHabit: update)
                                            .navigationBarBackButtonHidden()
                                    } label: {
                                        HabitItemWithDateStatus(
                                            habit: habit,
                                            selectedDate: selectedDate,
                                            isCompleted: isCompletedOnSelectedDate
                                        )
                                    }
                                    .foregroundColor(.black)
                                    .onAppear{
                                        if !habitViewModel.habits.isEmpty{
                                            habitViewModel.scheduleAllNotifications()
                                            print("Notification Created")
                                        }
                                    }
                                }


                               
                            }
                            .padding(.top)

                        }
                    }
                    .background(viewModel.barStyle == .barstyle1 ? Color(.systemGroupedBackground) : Color(.systemBackground))
                }
                
                
                AddHabitButton
            }
            .fullScreenCover(isPresented: $homeViewModel.showAddView) {
                AddHabitView(soundVM: _soundVM)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            }
           
        }
    }
        
    
    var AddHabitButton : some View {
        HStack {
            Spacer()
            // Add New Habit Button
            Button(action: {
                homeViewModel.openAddHabitView()
            }) {
                HStack {
                    
                    Image(systemName: "plus.circle.fill")
                    
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.mint)
                .cornerRadius(16)
                .padding(.horizontal)
                .shadow(radius: 6)
            }
        }
    }
    
    var HomeViewHeaderView : some View {
        HStack {
            Image(systemName: "star.circle.fill")
                .font(.title)
                .foregroundStyle(.mint)
            Spacer()
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Text(homeViewModel.todayCalendarToStringHeader())
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                Button {
                    withAnimation {
                        showSearchBar.toggle()
                        if !showSearchBar {
                            searchText = ""
                        }
                    }
                } label: {
                    Image(systemName: showSearchBar ? "xmark.circle.fill" : "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                
                NavigationLink {
                    SettingsView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Image(systemName: "gearshape")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 12)
    }
    
    var filteredHabits: [Habit] {
        var habits = habitViewModel.habits
        
        // Search filter
        if !searchText.isEmpty {
            habits = habits.filter { habit in
                habit.title.localizedCaseInsensitiveContains(searchText) ||
                habit.category.localizedCaseInsensitiveContains(searchText) ||
                habit.emoji.contains(searchText)
            }
        }
        
        // Date filter - if a date is selected, show all habits but with their status for that date
        // (We'll show all habits, but mark which ones were completed on that date)
        return habits
    }
    
    func formatDateForHabit(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: date)
    }
    
    func isHabitCompletedOnDate(_ habit: Habit, date: Date) -> Bool {
        let dateString = formatDateForHabit(date)
        return habit.complatedDay.contains(dateString)
    }
    
    func dateSubtitle(for date: Date) -> String {
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

#Preview {
    HomeView()
        .environmentObject(HabitBarSettingsViewModel())
        .environmentObject(AddCustomHabitViewModel())
        .environmentObject(SoundViewModel())
        .environmentObject(ProgressViewModel())
    
}

