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
    @EnvironmentObject var progressVM: ProgressViewModel
    @State var animate2: Bool = false
    @StateObject var homeViewModel = HomeViewViewModel()



    

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
                    HStack {
                        Image(systemName: "star.circle.fill")
                            .font(.title)
                            .foregroundStyle(.mint)
                        Spacer()
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: 6) {
                                Text(takvim())
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 16) {

                            NavigationLink {
                                SettingsView()
                                    .navigationBarBackButtonHidden()
                            } label: {
                                Image(systemName: "gearshape")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)

                    // Calendar
                    HorizontalCalendarView()
                        .padding(.vertical)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.gray.opacity(0.1))
                        .shadow(color: .gray, radius: 4, x: 0, y: 2)

                    // Scrollable Content
                    ZStack {
                        ScrollView {
                            VStack {
                                
                                
                                ForEach(habitViewModel.habits) { habit in
                                    let update: (Habit) -> Void = { updatedHabit in
                                        Task {
                                            do {
                                                try await HabitService().updateHabit(updatedHabit)
                                            } catch {
                                                print("HATA: Firestore güncelleme hatası \(error.localizedDescription)")
                                            }
                                        }
                                    }

                                    NavigationLink {
                                        ProgressView(habit: habit, updateHabit: update)
                                            .navigationBarBackButtonHidden()
                                    } label: {
                                        HabitItem(habit: habit)
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
                    .background(viewModel.barStyle == .barstyle1 ? Color(.systemGroupedBackground) : Color.white)
                }
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
            .fullScreenCover(isPresented: $homeViewModel.showAddView) {
                AddHabitView(soundVM: _soundVM)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            }
            .task {
                Task {
                    
                    let habitService = HabitService() //Instance
                    for await habits in habitService.listenHabits() {
                        await habitService.resetHabitsIfNewDay(habits)
                    }
                }

            }
           
        }
    }
        

    
    func takvim() -> String {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd, MMMM" // Gün ve Ay (kısa)
        let formattedDate = formatter.string(from: today)
        return formattedDate
    }
}

#Preview {
    HomeView()
        .environmentObject(HabitBarSettingsViewModel())
        .environmentObject(AddCustomHabitViewModel())
        .environmentObject(SoundViewModel())
        .environmentObject(ProgressViewModel())
    
}

