//
//  SoundViewModel.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 1.05.2025.
//

import Foundation

enum Sound: String {
    case sound1 = "s1"
    case sound2 = "s2"
    case sound3 = "s3"
    case sound4 = "s4"
    case sound5 = "s5"
    case sound6 = "s6"
}

class SoundViewModel: ObservableObject {
    @Published var soundBar: Sound = .sound1
}
