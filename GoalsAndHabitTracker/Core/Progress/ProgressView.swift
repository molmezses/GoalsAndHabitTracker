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
    @State var animate:Bool = false
    @State var habit: Habit

    
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
                            .clipShape(Circle())
                    }

                    Spacer()
                    
                    Text(habit.title)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                        // settings or edit action
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
                        .stroke(habit.color ,style: StrokeStyle(lineWidth: 12, lineCap: .round)
                        )
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
                            habit.current = max(habit.current - 10, 0)
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
                            habit.current = min(habit.current + 10, habit.total)
                        } label: {
                            Image(systemName: "plus")
                                .foregroundStyle(.black)
                                .padding(6)
                                .font(.headline)
                                .background(Color(.systemGroupedBackground))
                                .clipShape(Circle())
                        }
                        .padding(.leading , 6)

                        
                    }
                }
                .padding(.bottom)
                .opacity(animate ? 1 : 0)
                .offset(y: animate ? 0 : 20)
                .animation(.easeInOut(duration: 0.6), value: animate)

                
                Spacer()
                
                
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
                    Button {
                        showSheet.toggle()
                    } label: {
                        Image(systemName: "gear")
                            .foregroundStyle(.black)
                            .padding()
                            .font(.headline)
                            .fontDesign(.rounded)
                            .background(Color(.systemGroupedBackground))
                            .clipShape(Circle())
                    }

                }
                .fullScreenCover(isPresented: $showSheet) {
                    StatusView(habit: habit)
                }
                .opacity(animate ? 1 : 0)
                .offset(y: animate ? 0 : 20)
                .animation(.easeInOut(duration: 0.6), value: animate)
                .onAppear {
                    animate = true
                }
                Spacer()
            }

            
            
        }
    }
}

#Preview {
    ProgressView(habit: Habit.MOCK_HABIT[2])
}


//habit.current = min(habit.current + 10, habit.total)
//habit.current = max(habit.current - 10, 0)
//habit.current = 0


