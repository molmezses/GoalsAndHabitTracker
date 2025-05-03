//
//  HabitItem.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 22.04.2025.
//

import SwiftUI

struct HabitItem: View {
   
    @State var animate: Bool = false
    let habit: Habit
    @EnvironmentObject var viewModel : HabitBarSettingsViewModel
    
    var body: some View {
        
        if viewModel.barStyle == .barstyle4 {
            ZStack(alignment: .leading) {
                GeometryReader { geometry in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    
                    RoundedRectangle(cornerRadius: 12)
                        .fill(habit.color.opacity(0))
                        .frame(width: width * (habit.current/habit.total), height: height)
                }
                
                HStack {
                    Text(habit.emoji)
                        .font(.title)
                        .padding(8)
                        .background(habit.color.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    VStack(spacing: 8) {
                        Text(habit.title)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack{
                            Text("\(Int(habit.current))/\(Int(habit.total)) \(habit.category)")
                                .font(.footnote)
                            Text("|")
                            Image(systemName: "clock")
                                .font(.footnote)
                            Text("\(habit.reminderTime)")
                                .font(.footnote)
                            Spacer()

                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.black)

                    }
                    .padding(.vertical)
                    .fontDesign(.rounded)
                    
                    Spacer()
                    
                    Image(systemName: isComplated() ? "checkmark" : "")
                        .foregroundColor(isComplated() ? habit.color : .gray)
                        .imageScale(.large)
                        .bold()
                }
                .padding(.horizontal)
            }
            .frame(height: 80)
            .background(habit.color.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(habit.color ,lineWidth: 2)
            )
            .padding(.horizontal)
            .padding(.vertical, 8)
            .opacity(animate ? 1 : 0)
            .offset(y: animate ? 0 : 20)
            .animation(.easeInOut(duration: 0.6), value: animate)
            .onAppear {
                animate = true
            }
        }
        
        if viewModel.barStyle == .barstyle2 {
            ZStack(alignment: .leading) {
                GeometryReader { geometry in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    
                    RoundedRectangle(cornerRadius: 12)
                        .fill(habit.color.opacity(0.6))
                        .frame(width: width * (habit.current/habit.total), height: height)
                }
                
                HStack {
                    Text(habit.emoji)
                        .font(.title)
                        .padding(8)
                        .background(habit.color.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    VStack(spacing: 8) {
                        Text(habit.title)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack{
                            Text("\(Int(habit.current))/\(Int(habit.total)) \(habit.category)")
                                .font(.footnote)
                            Text("|")
                            Image(systemName: "clock")
                                .font(.footnote)
                            Text("\(habit.reminderTime)")
                                .font(.footnote)
                            Spacer()

                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.black)

                    }
                    .padding(.vertical)
                    .fontDesign(.rounded)
                    
                    Spacer()
                    
                    Image(systemName: isComplated() ? "checkmark" : "")
                        .foregroundColor(isComplated() ? .white : .gray)
                        .imageScale(.large)
                        .bold()
                }
                .padding(.horizontal)
            }
            .frame(height: 80)
            .background(habit.color.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal)
            .padding(.vertical, 8)
            .opacity(animate ? 1 : 0)
            .offset(y: animate ? 0 : 20)
            .animation(.easeInOut(duration: 0.6), value: animate)
            .onAppear {
                animate = true
            }
        }
        
        if viewModel.barStyle == .barstyle3 {
            ZStack(alignment: .leading) {
                GeometryReader { geometry in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    
                    RoundedRectangle(cornerRadius: 12)
                        .fill(habit.color.opacity(1))
                        .frame(width: width * (habit.current/habit.total), height: height * 0.05)
                }
                
                HStack {
                    Text(habit.emoji)
                        .font(.title)
                        .padding(8)
                        .background(habit.color.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    VStack(spacing: 8) {
                        Text(habit.title)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack{
                            Text("\(Int(habit.current))/\(Int(habit.total)) \(habit.category)")
                                .font(.footnote)
                            Text("|")
                            Image(systemName: "clock")
                                .font(.footnote)
                            Text("\(habit.reminderTime)")
                                .font(.footnote)
                            Spacer()

                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.black)

                    }
                    .padding(.vertical)
                    .fontDesign(.rounded)
                    
                    Spacer()
                    
                    Image(systemName: isComplated() ? "checkmark" : "")
                        .foregroundColor(isComplated() ? habit.color : .gray)
                        .imageScale(.large)
                        .bold()
                }
                .padding(.horizontal)
            }
            .frame(height: 80)
            .background(habit.color.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal)
            .padding(.vertical, 8)
            .opacity(animate ? 1 : 0)
            .offset(y: animate ? 0 : 20)
            .animation(.easeInOut(duration: 0.6), value: animate)
            .onAppear {
                animate = true
            }
        }
        
        if viewModel.barStyle == .barstyle5 {
            ZStack(alignment: .leading) {
                GeometryReader { geometry in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    
                    RoundedRectangle(cornerRadius: 12)
                        .fill(habit.color.opacity(1))
                        .frame(width: width * (0.026), height: height)
                }
                
                HStack {
                    Text(habit.emoji)
                        .font(.title)
                        .padding(8)
                        .background(habit.color.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    VStack(spacing: 8) {
                        Text(habit.title)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack{
                            Text("\(Int(habit.current))/\(Int(habit.total)) \(habit.category)")
                                .font(.footnote)
                            Text("|")
                            Image(systemName: "clock")
                                .font(.footnote)
                            Text("\(habit.reminderTime)")
                                .font(.footnote)
                            Spacer()

                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.black)

                    }
                    .padding(.vertical)
                    .fontDesign(.rounded)
                    
                    Spacer()
                    
                    Image(systemName: isComplated() ? "checkmark" : "")
                        .foregroundColor(isComplated() ? habit.color : .gray)
                        .imageScale(.large)
                        .bold()
                }
                .padding(.horizontal)
            }
            .frame(height: 80)
            .background(habit.color.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal)
            .padding(.vertical, 8)
            .opacity(animate ? 1 : 0)
            .offset(y: animate ? 0 : 20)
            .animation(.easeInOut(duration: 0.6), value: animate)
            .onAppear {
                animate = true
            }
        }
        
        if viewModel.barStyle == .barstyle6 {
            ZStack(alignment: .leading) {
                GeometryReader { geometry in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    
                    RoundedRectangle(cornerRadius: 12)
                        .fill(habit.color.opacity(0))
                        .frame(width: width * (habit.current/habit.total), height: height)
                }
                
                HStack {
                    Text(habit.emoji)
                        .font(.title)
                        .padding(8)
                        .background(habit.color.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    VStack(spacing: 8) {
                        Text(habit.title)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack{
                            Text("\(Int(habit.current))/\(Int(habit.total)) \(habit.category)")
                                .font(.footnote)
                            Text("|")
                            Image(systemName: "clock")
                                .font(.footnote)
                            Text("\(habit.reminderTime)")
                                .font(.footnote)
                            Spacer()

                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.black)

                    }
                    .padding(.vertical)
                    .fontDesign(.rounded)
                    
                    Spacer()
                    
                    Image(systemName: isComplated() ? "checkmark" : "")
                        .foregroundColor(isComplated() ? habit.color : .gray)
                        .imageScale(.large)
                        .bold()
                }
                .padding(.horizontal)
            }
            .frame(height: 80)
            .background(habit.color.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(habit.color ,lineWidth: 2)
            )
            .padding(.horizontal)
            .padding(.vertical, 8)
            .opacity(animate ? 1 : 0)
            .offset(y: animate ? 0 : 20)
            .animation(.easeInOut(duration: 0.6), value: animate)
            .onAppear {
                animate = true
            }
        }
        
        if viewModel.barStyle == .barstyle1 {
            ZStack(alignment: .leading) {
                
                HStack {
                    Text(habit.emoji)
                        .font(.title)
                        .padding(8)
                        .background(habit.color.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    VStack(spacing: 8) {
                        Text(habit.title)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack{
                            Text("\(Int(habit.current))/\(Int(habit.total)) \(habit.category)")
                                .font(.footnote)
                            Text("|")
                            Image(systemName: "clock")
                                .font(.footnote)
                            Text("\(habit.reminderTime)")
                                .font(.footnote)
                            Spacer()

                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.black)

                    }
                    .padding(.vertical)
                    .fontDesign(.rounded)
                    
                    Spacer()
                    
                    Image(systemName: isComplated() ? "checkmark" : "")
                        .foregroundColor(isComplated() ? habit.color : .gray)
                        .imageScale(.large)
                        .bold()
                }
                .padding(.horizontal)
            }
            .frame(height: 80)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal)
            .padding(.vertical, 8)
            .opacity(animate ? 1 : 0)
            .offset(y: animate ? 0 : 20)
            .animation(.easeInOut(duration: 0.6), value: animate)
            .onAppear {
                animate = true
            }
        }

        
        
        
    }
    
    func isComplated() -> Bool {
        if habit.current == habit.total {
            return true
        }
        return false
    }

}


#Preview {
    HabitItem(habit: Habit.MOCK_HABIT[0])
        .environmentObject(HabitBarSettingsViewModel())
        
}
