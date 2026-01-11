//
//  NoHabitView.swift
//  GoalsAndHabitTracker
//
//  Created by mustafaolmezses on 11.01.2026.
//

import SwiftUI

struct NoHabitView: View {
    
    @StateObject var viewModel = NoHabitViewModel()
    let onAddTapped: () -> Void

    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            VStack {
                Text("No Habits Yet! 👑")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("Start building your best self today. Tap the button below to create your first habit and take control of your day!")
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
            }
            .foregroundStyle(.gray)
            
            Button(action: {
                onAddTapped()
            }) {
                Text("Create a Habit 💡")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(viewModel.animate2 ? .teal : .mint)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal , viewModel.animate2 ? 40 : 50)
            .shadow(color: (viewModel.animate2 ? Color.teal : Color.mint).opacity(0.4),
                    radius: viewModel.animate2 ? 10 : 6,
                    x: 0,
                    y: viewModel.animate2 ? 10 : 6)
            .scaleEffect(viewModel.animate2 ? 1.03 : 1.0)
            .offset(y: viewModel.animate2 ? -3 : 0)
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .multilineTextAlignment(.center)
        .padding(32)
        .onAppear(perform: viewModel.addAnimation)
    }
}

