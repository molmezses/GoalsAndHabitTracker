//
//  ProgressView.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 22.04.2025.
//

import SwiftUI

struct ProgressView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var showSheet = false
    @State private var showPopupMenu = false
    @State var animate: Bool = false
    @State var habit: Habit
    var updateHabit: (Habit) -> Void
    @EnvironmentObject var viewModel: ProgressViewModel
    @State var goToHome: Bool = false
    

    var body: some View {
        ZStack {
            NavigationStack {
                VStack(spacing: 0) {
                    
                    // Header
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
                        
                        Spacer()
                        
                        Button {
                            showPopupMenu.toggle()
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

                    // Big Circular Progress
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.2), lineWidth: 12)
                        
                        Circle()
                            .trim(from: 0, to: Double(habit.current / habit.total))
                            .stroke(habit.color ,style: StrokeStyle(lineWidth: 12, lineCap: .round))
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
                    .opacity(animate ? 1 : 0)
                    .offset(y: animate ? 0 : 20)
                    .animation(.easeInOut(duration: 0.6), value: animate)
                    .onAppear {
                        animate = true
                    }

                    // Buttons
                    VStack(spacing: 4) {
                        HStack(spacing: 12) {
                            
                            Button {
                                habit.current = max(habit.current - (habit.total / 10), 0)
                                viewModel.fetchCompletedDayAndRemove(habit: &habit)
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
                    .opacity(animate ? 1 : 0)
                    .offset(y: animate ? 0 : 20)
                    .animation(.easeInOut(duration: 0.6), value: animate)
                    
                    Spacer()
                    
                    // Bottom Buttons
                    HStack {
                        Button {
                            showSheet.toggle()
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
                    .fullScreenCover(isPresented: $showSheet) {
                        StatusView(habit: habit)
                            .environmentObject(StatusViewModel())
                    }
                    .opacity(animate ? 1 : 0)
                    .offset(y: animate ? 0 : 20)
                    .animation(.easeInOut(duration: 0.6), value: animate)
                    
                    Spacer()
                }
                .navigationDestination(isPresented: $goToHome) {
                    HomeView()
                        .navigationBarBackButtonHidden()
                        .environmentObject(AddCustomHabitViewModel())
                        .environmentObject(HabitBarSettingsViewModel())
                        .environmentObject(StatusViewModel())
                        .environmentObject(ProgressViewModel())
                        .environmentObject(UpdateViewModel())
                }
            }

            // Overlay popup menu
            if showPopupMenu {
                Color.black.opacity(0.001)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showPopupMenu = false
                    }

                VStack {
                    Spacer().frame(height: UIScreen.main.bounds.height * 0.07)
                    HStack {
                        Spacer()
                        VStack(spacing: 0) {
                            Button(action: {
                                FirestoreManager.sharedFirestoreManager.deleteHabit(habit) { result in
                                    switch result{
                                    case .success:
                                        print("Habit silindi")
                                    case .failure:
                                        print("Habit silinemsi hatasu")
                                    }
                                }
                                showPopupMenu = false
                                goToHome = true
                            }, label: {
                                HStack {
                                    Image(systemName: "trash")
                                    Text("Delete Habit")
                                }
                                .padding()
                            })
                            .foregroundStyle(.red)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .shadow(radius: 8)
                        )
                        .padding(.trailing)
                    }
                    Spacer()
                }
                .transition(.scale)
                .animation(.easeInOut, value: showPopupMenu)
            }
        }
    }
}

#Preview {
    ProgressView(habit: Habit.MOCK_HABIT[0]) { _ in }
        .environmentObject(StatusViewModel())
        .environmentObject(ProgressViewModel())
        .environmentObject(UpdateViewModel())
        .environmentObject(SoundViewModel())
}
