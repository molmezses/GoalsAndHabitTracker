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
                                AddCustomHabitView()
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

                            AddHabitButtonBar(title: "Drink Water", color: .blue, icon: "💧")
                                .opacity(animate ? 1 : 0)
                                .offset(y: animate ? 0 : 20)
                                .animation(.easeInOut(duration: 0.4), value: animate)
                                .onAppear {
                                    animate = true
                                }
                            AddHabitButtonBar(title: "Walk", color: .green, icon: "🚶‍♂️")
                                .opacity(animate ? 1 : 0)
                                .offset(y: animate ? 0 : 20)
                                .animation(.easeInOut(duration: 0.46), value: animate)
                                .onAppear {
                                    animate = true
                                }
                            AddHabitButtonBar(title: "Run", color: .orange, icon: "🏃")
                                .opacity(animate ? 1 : 0)
                                .offset(y: animate ? 0 : 20)
                                .animation(.easeInOut(duration: 0.52), value: animate)
                                .onAppear {
                                    animate = true
                                }
                            AddHabitButtonBar(title: "Cycling", color: .purple, icon: "🚴‍♂️")
                                .opacity(animate ? 1 : 0)
                                .offset(y: animate ? 0 : 20)
                                .animation(.easeInOut(duration: 0.56), value: animate)
                                .onAppear {
                                    animate = true
                                }
                            AddHabitButtonBar(title: "Workout", color: .teal, icon: "💪🏻")
                                .opacity(animate ? 1 : 0)
                                .offset(y: animate ? 0 : 20)
                                .animation(.easeInOut(duration: 0.60), value: animate)
                                .onAppear {
                                    animate = true
                                }
                            AddHabitButtonBar(title: "Calories", color: .red, icon: "🫀")
                                .opacity(animate ? 1 : 0)
                                .offset(y: animate ? 0 : 20)
                                .animation(.easeInOut(duration: 0.65), value: animate)
                                .onAppear {
                                    animate = true
                                }
                            AddHabitButtonBar(title: "Meditation", color: .yellow, icon: "🧘🏻‍♂️")
                                .opacity(animate ? 1 : 0)
                                .offset(y: animate ? 0 : 20)
                                .animation(.easeInOut(duration: 0.70), value: animate)
                                .onAppear {
                                    animate = true
                                }
                            AddHabitButtonBar(title: "Read a book", color: .indigo, icon: "📚")
                                .opacity(animate ? 1 : 0)
                                .offset(y: animate ? 0 : 20)
                                .animation(.easeInOut(duration: 0.74), value: animate)
                                .onAppear {
                                    animate = true
                                }
                            AddHabitButtonBar(title: "Drink less Cigarette", color: .blue, icon: "🚬")
                                .opacity(animate ? 1 : 0)
                                .offset(y: animate ? 0 : 20)
                                .animation(.easeInOut(duration: 0.78), value: animate)
                                .onAppear {
                                    animate = true
                                }
                            AddHabitButtonBar(title: "Learn a language", color: .pink, icon: "🔇")
                                .opacity(animate ? 1 : 0)
                                .offset(y: animate ? 0 : 20)
                                .animation(.easeInOut(duration: 0.80), value: animate)
                                .onAppear {
                                    animate = true
                                }
                            AddHabitButtonBar(title: "Sleep Early", color: .orange, icon: "😴")
                                .opacity(animate ? 1 : 0)
                                .offset(y: animate ? 0 : 20)
                                .animation(.easeInOut(duration: 0.84), value: animate)
                                .onAppear {
                                    animate = true
                                }
                            AddHabitButtonBar(title: "Eat Low-Fat", color: .green, icon: "🥗")
                                .opacity(animate ? 1 : 0)
                                .offset(y: animate ? 0 : 20)
                                .animation(.easeInOut(duration: 0.88), value: animate)
                                .onAppear {
                                    animate = true
                                }
                            AddHabitButtonBar(title: "Ear Less Sugar", color: .teal, icon: "🍭")
                                .opacity(animate ? 1 : 0)
                                .offset(y: animate ? 0 : 20)
                                .animation(.easeInOut(duration: 0.90), value: animate)
                                .onAppear {
                                    animate = true
                                }
                            AddHabitButtonBar(title: "Yoga", color:.pink, icon: "🧘🏻‍♀️")
                                .opacity(animate ? 1 : 0)
                                .offset(y: animate ? 0 : 20)
                                .animation(.easeInOut(duration: 0.9), value: animate)
                                .onAppear {
                                    animate = true
                                }
                            AddHabitButtonBar(title: "Less Social App", color: .indigo, icon: "📱")
                                .opacity(animate ? 1 : 0)
                                .offset(y: animate ? 0 : 20)
                                .animation(.easeInOut(duration: 0.9), value: animate)
                                .onAppear {
                                    animate = true
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
        }
    }
}

#Preview {
    AddHabitView()
        .environmentObject(AddCustomHabitViewModel())
}
