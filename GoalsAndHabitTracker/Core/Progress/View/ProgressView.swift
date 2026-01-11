//
//  ProgressView.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 22.04.2025.
//

import SwiftUI

struct ProgressView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var habit: Habit
    var updateHabit: (Habit) -> Void
    
    
    @StateObject var viewModel = ProgressViewModel()
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                // Header
                ProgressViewHeader
                
                // Big Circular Progress
                CircularProgressView
                
                // Habit Value Buttons
                HabitValueButtons
                
                Spacer()
                
                // Chart And Habit Setting Buttons
                ChartAndHabitSettingButtons
                
                Spacer()
            }
            .navigationDestination(isPresented: $viewModel.goToHome) {
                HomeView()
                    .navigationBarBackButtonHidden()
                    .environmentObject(AddCustomHabitViewModel())
                    .environmentObject(HabitBarSettingsViewModel())
                    .environmentObject(StatusViewModel())
                    .environmentObject(UpdateViewModel())
            }
            
            
            
            // Delete  habit Popup button
            if viewModel.showPopupMenu {
                HabitActionPopup(
                    onDelete: {
                        viewModel.deleteHabit(habit: habit)
                    },
                    onDismiss: {
                        viewModel.showPopupMenu = false
                    }
                )
            }
        }
    }
    
    var ProgressViewHeader: some View{
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .padding(8)
                    .clipShape(Circle())
            }
            
            Spacer()
            
            Text(habit.title)
                .font(.headline)
                .fontWeight(.bold)
                .lineLimit(1)
            
            Spacer()
            
            Button {
                viewModel.showPopupMenu.toggle()
            } label: {
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding(8)
                    .clipShape(Circle())
            }
        }
        .padding()
    }
    
    var CircularProgressView: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 12)
            
            Circle()
                .trim(from: 0, to: Double(habit.current / habit.total))
                .stroke(habit.color ,style: StrokeStyle(lineWidth: 24, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: habit.current)
            
            VStack(spacing: 8) {
                Text(habit.emoji)
                    .font(.system(size: 48))
                HStack {
                    Text("\(Int(habit.current))")
                    Text("Times")
                }
                .font(.title2)
                HStack(spacing:0){
                    Text("/")
                    Text("\(Int(habit.total))")
                }
                .foregroundStyle(.gray)
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.5)
        .padding(.top)
        .opacity(viewModel.animate ? 1 : 0)
        .offset(y: viewModel.animate ? 0 : 20)
        .animation(.easeInOut(duration: 0.6), value: viewModel.animate)
        .onAppear {
            viewModel.animate = true
        }
    }
    
    var HabitValueButtons: some View{
        VStack(spacing: 4) {
            HStack(spacing: 12) {
                
                Button {
                    habit.current = max(habit.current - (habit.total / 10), 0)
                    viewModel.removeTodayIfCompleted(habit: &habit)
                    habit.missing = viewModel.calcMissingDay(habit: habit)
                    updateHabit(habit)
                } label: {
                    Image(systemName: "minus")
                        .foregroundStyle(.black)
                        .padding()
                        .font(.headline)
                        .background(Color(.systemGroupedBackground))
                        .clipShape(Circle())
                }
                
                Button {
                    habit.current = habit.total
                    if habit.current == habit.total {
                        print("oldu")
                        let date = viewModel.formattedTodayDate()
                        habit.complatedDay.append(date)
                    }
                    updateHabit(habit)
                } label: {
                    Image(systemName: "checkmark")
                        .imageScale(.large)
                        .bold()
                        .padding()
                        .foregroundStyle(.white)
                        .background(habit.color)
                        .mask(Circle())
                }
                
                Button {
                    habit.current = min(habit.current + (habit.total / 10), habit.total)
                    if habit.current == habit.total {
                        print("oldu")
                        let date = viewModel.formattedTodayDate()
                        habit.complatedDay.append(date)
                    }
                    updateHabit(habit)
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.black)
                        .padding(6)
                        .font(.headline)
                        .background(Color(.systemGroupedBackground))
                        .clipShape(Circle())
                }
                .padding(.leading , 6)
                .disabled(viewModel.disableButton(habit: habit))
                .opacity(viewModel.disableButton(habit: habit) ? 0 : 1)
            }
        }
        .padding(.bottom)
        .opacity(viewModel.animate ? 1 : 0)
        .offset(y: viewModel.animate ? 0 : 20)
        .animation(.easeInOut(duration: 0.6), value: viewModel.animate)
    }
    
    var ChartAndHabitSettingButtons: some View {
        HStack {
            Button {
                viewModel.showSheet.toggle()
            } label: {
                Image(systemName: "chart.bar.fill")
                    .foregroundStyle(.black)
                    .padding()
                    .font(.headline)
                    .fontDesign(.rounded)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Circle())
            }
            NavigationLink {
                UpdateView(habit: habit)
                    .navigationBarBackButtonHidden()
            } label: {
                Image(systemName: "gear")
                    .foregroundStyle(.black)
                    .padding()
                    .font(.headline)
                    .fontDesign(.rounded)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Circle())
            }
            .foregroundStyle(.black)
        }
        .fullScreenCover(isPresented: $viewModel.showSheet) {
            StatusView(habit: habit)
                .environmentObject(StatusViewModel())
        }
        .opacity(viewModel.animate ? 1 : 0)
        .offset(y: viewModel.animate ? 0 : 20)
        .animation(.easeInOut(duration: 0.6), value: viewModel.animate)
    }
}


