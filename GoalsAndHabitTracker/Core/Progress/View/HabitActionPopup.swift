//
//  HabitActionPopup.swift
//  GoalsAndHabitTracker
//
//  Created by mustafaolmezses on 11.01.2026.
//

import SwiftUI


struct HabitActionPopup: View {
    
    let onDelete: () -> Void
    let onDismiss: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.001)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss()
                }

            VStack {
                Spacer().frame(height: UIScreen.main.bounds.height * 0.07)

                HStack {
                    Spacer()

                    VStack(spacing: 0) {
                        Button {
                            onDelete()
                        } label: {
                            HStack {
                                Image(systemName: "trash")
                                Text("Delete Habit")
                            }
                            .padding()
                        }
                        .foregroundStyle(.red)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemBackground))
                            .shadow(radius: 8)
                    )
                    .padding(.trailing)
                }

                Spacer()
            }
        }
        .transition(.scale)
        .animation(.easeInOut, value: UUID())
    }
}


