//
//  AddHabitView.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 22.04.2025.
//


import SwiftUI

struct AddHabitView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var animate: Bool = false
    @EnvironmentObject var viewModel: AddCustomHabitViewModel
    @EnvironmentObject var soundVM: SoundViewModel

    @State var navigateCusHabit: Bool = false

    
    var body: some View {
        NavigationStack{
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
                            .background(Color.white)
                            .clipShape(Circle())
                    }

                    Spacer()
                    
                    Text("Add a new task")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                                            } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                }
                .padding()
                .background(Color.white)
                
                Spacer()
                
                ZStack {
                    Color(.systemGroupedBackground).ignoresSafeArea()
                    
                    ScrollView {
                        VStack {
                            
                            NavigationLink {
                                AddCustomHabitView(soundVM: _soundVM)
                                    .navigationBarBackButtonHidden()
                            } label: {
                                HStack {
                                    Spacer()
        
                                    Text("Add a custom habbit")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Spacer()
                                }
                                .padding(18)
                                .background(.mint)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .padding(.horizontal)
                                .fontDesign(.rounded)
                                .padding(.bottom , 4)
                            }
                            
                            Button {
                                viewModel.title = "Run"
                                viewModel.color = .orange
                                viewModel.selectedEmoji = "🏃"
                                viewModel.selectedUnit = "km"
                                navigateCusHabit = true
                            } label: {
                                AddHabitButtonBar(title: "Run", color: .orange, icon: "🏃")
                                    .modifier(HabitButtonAppearModifier(animate: $animate, delay: 0.52))
                            }

                            Button {
                                viewModel.title = "Cycling"
                                viewModel.color = .purple
                                viewModel.selectedEmoji = "🚴‍♂️"
                                viewModel.selectedUnit = "km"
                                navigateCusHabit = true
                            } label: {
                                AddHabitButtonBar(title: "Cycling", color: .purple, icon: "🚴‍♂️")
                                    .modifier(HabitButtonAppearModifier(animate: $animate, delay: 0.56))
                            }

                            Button {
                                viewModel.title = "Workout"
                                viewModel.color = .teal
                                viewModel.selectedEmoji = "💪🏻"
                                viewModel.selectedUnit = "Exercise"
                                navigateCusHabit = true
                            } label: {
                                AddHabitButtonBar(title: "Workout", color: .teal, icon: "💪🏻")
                                    .modifier(HabitButtonAppearModifier(animate: $animate, delay: 0.60))
                            }

                            Button {
                                viewModel.title = "Calories"
                                viewModel.color = .red
                                viewModel.selectedEmoji = "🫀"
                                viewModel.selectedUnit = "Calorie"
                                navigateCusHabit = true
                            } label: {
                                AddHabitButtonBar(title: "Calories", color: .red, icon: "🫀")
                                    .modifier(HabitButtonAppearModifier(animate: $animate, delay: 0.65))
                            }

                            Button {
                                viewModel.title = "Meditation"
                                viewModel.color = .yellow
                                viewModel.selectedEmoji = "🧘🏻‍♂️"
                                viewModel.selectedUnit = "Minute"
                                navigateCusHabit = true
                            } label: {
                                AddHabitButtonBar(title: "Meditation", color: .yellow, icon: "🧘🏻‍♂️")
                                    .modifier(HabitButtonAppearModifier(animate: $animate, delay: 0.70))
                            }

                            Button {
                                viewModel.title = "Read a book"
                                viewModel.color = .indigo
                                viewModel.selectedEmoji = "📚"
                                viewModel.selectedUnit = "Page"
                                navigateCusHabit = true
                            } label: {
                                AddHabitButtonBar(title: "Read a book", color: .indigo, icon: "📚")
                                    .modifier(HabitButtonAppearModifier(animate: $animate, delay: 0.74))
                            }

                            Button {
                                viewModel.title = "Drink less Cigarette"
                                viewModel.color = .blue
                                viewModel.selectedEmoji = "🚬"
                                viewModel.selectedUnit = "Piece"
                                navigateCusHabit = true
                            } label: {
                                AddHabitButtonBar(title: "Drink less Cigarette", color: .blue, icon: "🚬")
                                    .modifier(HabitButtonAppearModifier(animate: $animate, delay: 0.78))
                            }
                            
                            Button {
                                viewModel.title = "Drink less Alcohol"
                                viewModel.color = .orange
                                viewModel.selectedEmoji = "🍺"
                                viewModel.selectedUnit = "Bottle"
                                navigateCusHabit = true
                            } label: {
                                AddHabitButtonBar(title: "Drink less Alcohol", color: .blue, icon: "🚬")
                                    .modifier(HabitButtonAppearModifier(animate: $animate, delay: 0.79))
                            }

                            Button {
                                viewModel.title = "Learn a language"
                                viewModel.color = .pink
                                viewModel.selectedEmoji = "🔇"
                                viewModel.selectedUnit = "Word"
                                navigateCusHabit = true
                            } label: {
                                AddHabitButtonBar(title: "Learn a language", color: .pink, icon: "🔇")
                                    .modifier(HabitButtonAppearModifier(animate: $animate, delay: 0.80))
                            }

                            Button {
                                viewModel.title = "Sleep Early"
                                viewModel.color = .orange
                                viewModel.selectedEmoji = "😴"
                                viewModel.selectedUnit = "Hour"
                                navigateCusHabit = true
                            } label: {
                                AddHabitButtonBar(title: "Sleep Early", color: .orange, icon: "😴")
                                    .modifier(HabitButtonAppearModifier(animate: $animate, delay: 0.84))
                            }

                            Button {
                                viewModel.title = "Eat Low-Fat"
                                viewModel.color = .green
                                viewModel.selectedEmoji = "🥗"
                                viewModel.selectedUnit = "Calorie"
                                navigateCusHabit = true
                            } label: {
                                AddHabitButtonBar(title: "Eat Low-Fat", color: .green, icon: "🥗")
                                    .modifier(HabitButtonAppearModifier(animate: $animate, delay: 0.88))
                            }

                            Button {
                                viewModel.title = "Eat Less Sugar"
                                viewModel.color = .teal
                                viewModel.selectedEmoji = "🍭"
                                viewModel.selectedUnit = "Calorie"
                                navigateCusHabit = true
                            } label: {
                                AddHabitButtonBar(title: "Eat Less Sugar", color: .teal, icon: "🍭")
                                    .modifier(HabitButtonAppearModifier(animate: $animate, delay: 0.90))
                            }

                            Button {
                                viewModel.title = "Yoga"
                                viewModel.color = .pink
                                viewModel.selectedEmoji = "🧘🏻‍♀️"
                                viewModel.selectedUnit = "Minute"
                                navigateCusHabit = true
                            } label: {
                                AddHabitButtonBar(title: "Yoga", color: .pink, icon: "🧘🏻‍♀️")
                                    .modifier(HabitButtonAppearModifier(animate: $animate, delay: 0.90))
                            }

                            Button {
                                viewModel.title = "Less Social App"
                                viewModel.color = .indigo
                                viewModel.selectedEmoji = "📱"
                                viewModel.selectedUnit = "Minute"
                                navigateCusHabit = true
                            } label: {
                                AddHabitButtonBar(title: "Less Social App", color: .indigo, icon: "📱")
                                    .modifier(HabitButtonAppearModifier(animate: $animate, delay: 0.90))
                            }
                            
                            Button {
                                viewModel.title = "Drink Glass Of Water"
                                viewModel.color = .blue
                                viewModel.selectedEmoji = "💧"
                                viewModel.selectedUnit = "Glass Of Water"
                                navigateCusHabit = true
                            } label: {
                                AddHabitButtonBar(title: "Drink Glass Of Water", color: .blue, icon: "💧")
                                    .modifier(HabitButtonAppearModifier(animate: $animate, delay: 0.92))
                            }


                            

                            
                        }//contnt v
                        .padding(.vertical)
                        .padding(.top , 4)
                        .opacity(animate ? 1 : 0)
                        .offset(y: animate ? 0 : 20)
                        .animation(.easeInOut(duration: 0.6), value: animate)
                        .onAppear {
                            animate = true
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $navigateCusHabit) {
                AddCustomHabitView(soundVM: _soundVM)
                    .navigationBarBackButtonHidden()
            }
        }
    }
}

struct HabitButtonAppearModifier: ViewModifier {
    @Binding var animate: Bool
    var delay: Double

    func body(content: Content) -> some View {
        content
            .opacity(animate ? 1 : 0)
            .offset(y: animate ? 0 : 20)
            .animation(.easeInOut(duration: delay), value: animate)
            .onAppear {
                animate = true
            }
            .foregroundStyle(.black)
    }
}


#Preview {
    AddHabitView()
        .environmentObject(AddCustomHabitViewModel())
        .environmentObject(SoundViewModel())
}
