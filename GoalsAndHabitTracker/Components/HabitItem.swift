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
                        .frame(width: width * habit.progressPercentage, height: height)
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
                            Text(habit.countingMode == .timer ? 
                                 "\(formatTime(habit.timerElapsed))" : 
                                 "\(Int(habit.countingMode == .backward ? max(0, habit.current) : habit.current))/\(Int(habit.total)) \(habit.category)")
                                .font(.footnote)
                            Text("|")
                            Image(systemName: "clock")
                                .font(.footnote)
                            Text("\(formatHour(from: habit.reminderTime))")
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
                        .frame(width: width * habit.progressPercentage, height: height)
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
                            Text(habit.countingMode == .timer ? 
                                 "\(formatTime(habit.timerElapsed))" : 
                                 "\(Int(habit.countingMode == .backward ? max(0, habit.current) : habit.current))/\(Int(habit.total)) \(habit.category)")
                                .font(.footnote)
                            Text("|")
                            Image(systemName: "clock")
                                .font(.footnote)
                            Text("\(formatHour(from: habit.reminderTime))")
                                .font(.footnote)
                            Spacer()

                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.black)

                    }
                    .padding(.vertical)
                    .fontDesign(.rounded)
                    
                    Spacer()
                    
                    if isComplated(){
                        Image(systemName:"checkmark")
                            .foregroundColor(isComplated() ? .white : .gray)
                            .imageScale(.large)
                            .bold()
                    }
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
                        .frame(width: width * habit.progressPercentage, height: height * 0.05)
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
                            Text(habit.countingMode == .timer ? 
                                 "\(formatTime(habit.timerElapsed))" : 
                                 "\(Int(habit.countingMode == .backward ? max(0, habit.current) : habit.current))/\(Int(habit.total)) \(habit.category)")
                                .font(.footnote)
                            Text("|")
                            Image(systemName: "clock")
                                .font(.footnote)
                            Text("\(formatHour(from: habit.reminderTime))")
                                .font(.footnote)
                            Spacer()

                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.black)

                    }
                    .padding(.vertical)
                    .fontDesign(.rounded)
                    
                    Spacer()
                    
                    if isComplated(){
                        Image(systemName:"checkmark")
                            .foregroundColor(isComplated() ? habit.color : .gray)
                            .imageScale(.large)
                            .bold()
                    }
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
                            Text(habit.countingMode == .timer ? 
                                 "\(formatTime(habit.timerElapsed))" : 
                                 "\(Int(habit.countingMode == .backward ? max(0, habit.current) : habit.current))/\(Int(habit.total)) \(habit.category)")
                                .font(.footnote)
                            Text("|")
                            Image(systemName: "clock")
                                .font(.footnote)
                            Text("\(formatHour(from: habit.reminderTime))")
                                .font(.footnote)
                            Spacer()

                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.black)

                    }
                    .padding(.vertical)
                    .fontDesign(.rounded)
                    
                    Spacer()
                    
                    if isComplated(){
                        Image(systemName:"checkmark")
                            .foregroundColor(isComplated() ? habit.color : .gray)
                            .imageScale(.large)
                            .bold()
                    }
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
                        .frame(width: width * habit.progressPercentage, height: height)
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
                            Text(habit.countingMode == .timer ? 
                                 "\(formatTime(habit.timerElapsed))" : 
                                 "\(Int(habit.countingMode == .backward ? max(0, habit.current) : habit.current))/\(Int(habit.total)) \(habit.category)")
                                .font(.footnote)
                            Text("|")
                            Image(systemName: "clock")
                                .font(.footnote)
                            Text("\(formatHour(from: habit.reminderTime))")
                                .font(.footnote)
                            Spacer()

                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.black)

                    }
                    .padding(.vertical)
                    .fontDesign(.rounded)
                    
                    Spacer()
                    
                    if isComplated(){
                        Image(systemName:"checkmark")
                            .foregroundColor(isComplated() ? habit.color : .gray)
                            .imageScale(.large)
                            .bold()
                    }
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
                            Text(habit.countingMode == .timer ? 
                                 "\(formatTime(habit.timerElapsed))" : 
                                 "\(Int(habit.countingMode == .backward ? max(0, habit.current) : habit.current))/\(Int(habit.total)) \(habit.category)")
                                .font(.footnote)
                            Text("|")
                            Image(systemName: "clock")
                                .font(.footnote)
                            Text("\(formatHour(from: habit.reminderTime))")
                                .font(.footnote)
                            Spacer()

                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.black)

                    }
                    .padding(.vertical)
                    .fontDesign(.rounded)
                    
                    Spacer()
                    
                    if isComplated(){
                        Image(systemName:"checkmark")
                            .foregroundColor(isComplated() ? habit.color : .gray)
                            .imageScale(.large)
                            .bold()
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 80)
            .background(Color(.systemBackground))
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
        
        // Style 7: Card with Shadow
        if viewModel.barStyle == .barstyle7 {
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
                        Text(habit.countingMode == .timer ? 
                             "\(formatTime(habit.timerElapsed))" : 
                             "\(Int(habit.countingMode == .backward ? max(0, habit.total - habit.current) : habit.current))/\(Int(habit.total)) \(habit.category)")
                            .font(.footnote)
                        Text("|")
                        Image(systemName: "clock")
                            .font(.footnote)
                        Text("\(formatHour(from: habit.reminderTime))")
                            .font(.footnote)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.black)
                }
                .padding(.vertical)
                .fontDesign(.rounded)
                
                Spacer()
                
                if isComplated(){
                    Image(systemName:"checkmark.circle.fill")
                        .foregroundColor(isComplated() ? habit.color : .gray)
                        .imageScale(.large)
                }
            }
            .padding()
            .frame(height: 80)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: habit.color.opacity(0.3), radius: 8, x: 0, y: 4)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .opacity(animate ? 1 : 0)
            .offset(y: animate ? 0 : 20)
            .animation(.easeInOut(duration: 0.6), value: animate)
            .onAppear {
                animate = true
            }
        }
        
        // Style 8: Gradient Progress
        if viewModel.barStyle == .barstyle8 {
            ZStack(alignment: .leading) {
                GeometryReader { geometry in
                    LinearGradient(
                        colors: [habit.color, habit.color.opacity(0.6)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: geometry.size.width * habit.progressPercentage, height: geometry.size.height)
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
                            Text(habit.countingMode == .timer ? 
                                 "\(formatTime(habit.timerElapsed))" : 
                                 "\(Int(habit.countingMode == .backward ? max(0, habit.current) : habit.current))/\(Int(habit.total)) \(habit.category)")
                                .font(.footnote)
                            Text("|")
                            Image(systemName: "clock")
                                .font(.footnote)
                            Text("\(formatHour(from: habit.reminderTime))")
                                .font(.footnote)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.black)
                    }
                    .padding(.vertical)
                    .fontDesign(.rounded)
                    
                    Spacer()
                    
                    if isComplated(){
                        Image(systemName:"checkmark")
                            .foregroundColor(.white)
                            .imageScale(.large)
                            .bold()
                    }
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
        
        // Style 9: Compact Minimal
        if viewModel.barStyle == .barstyle9 {
            HStack(spacing: 12) {
                Text(habit.emoji)
                    .font(.title2)
                    .frame(width: 40, height: 40)
                    .background(habit.color.opacity(0.2))
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(habit.title)
                        .font(.headline)
                        .lineLimit(1)
                    
                    HStack(spacing: 4) {
                        Text(habit.countingMode == .timer ? 
                             "\(formatTime(habit.timerElapsed))" : 
                             "\(Int(habit.countingMode == .backward ? max(0, habit.total - habit.current) : habit.current))/\(Int(habit.total))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Circle()
                            .fill(habit.color)
                            .frame(width: 4, height: 4)
                        
                        Text("\(formatHour(from: habit.reminderTime))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                if isComplated(){
                    Image(systemName:"checkmark.circle.fill")
                        .foregroundColor(habit.color)
                        .imageScale(.medium)
                } else {
                    Circle()
                        .fill(habit.color.opacity(0.3))
                        .frame(width: 24, height: 24)
                        .overlay(
                            Circle()
                                .trim(from: 0, to: habit.progressPercentage)
                                .stroke(habit.color, lineWidth: 2)
                                .rotationEffect(.degrees(-90))
                        )
                }
            }
            .padding(12)
            .frame(height: 70)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
            .padding(.vertical, 6)
            .opacity(animate ? 1 : 0)
            .offset(y: animate ? 0 : 20)
            .animation(.easeInOut(duration: 0.6), value: animate)
            .onAppear {
                animate = true
            }
        }
    }
    
    func isComplated() -> Bool {
        return habit.isCompletedByMode
    }
    
    func formatHour(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    func formatTime(_ seconds: Double) -> String {
        let hours = Int(seconds) / 3600
        let minutes = (Int(seconds) % 3600) / 60
        let secs = Int(seconds) % 60
        
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, secs)
        } else {
            return String(format: "%d:%02d", minutes, secs)
        }
    }
    

}


#Preview {
    HabitItem(habit: Habit.MOCK_HABIT[0])
        .environmentObject(HabitBarSettingsViewModel())
        
}
