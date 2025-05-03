//
//  SoundBarView.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 1.05.2025.
//

import SwiftUI


struct SoundBarView: View {
    var title: String
    var color: Color
    var icon: String
    var isSelected: Bool
    var onTap: () -> Void
    @EnvironmentObject var viewModel : SoundViewModel
    
    var body: some View {
        Button {
            onTap()
            SoundManager.instance.playSound(sound: viewModel.soundBar.rawValue)
        } label: {
            HStack {
                Text(title)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.gray)
                }
            }
            .foregroundColor(.black)
            .padding(12)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .padding(.horizontal)
            .fontDesign(.rounded)
            .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: 1)
        }
    }
}



