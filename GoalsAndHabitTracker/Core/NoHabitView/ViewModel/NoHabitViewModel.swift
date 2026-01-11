//
//  NoHabitViewModel.swift
//  GoalsAndHabitTracker
//
//  Created by mustafaolmezses on 11.01.2026.
//

import Foundation
import SwiftUI

class NoHabitViewModel: ObservableObject {
    
    @Published var animate2: Bool = false

    
    func addAnimation(){
        
        guard !animate2 else {
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                self.animate2.toggle()
            }
        }
    }

}
