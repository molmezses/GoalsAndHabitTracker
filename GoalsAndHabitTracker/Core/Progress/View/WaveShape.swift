//
//  WaveShape.swift
//  GoalsAndHabitTracker
//
//  Created for wave progress animation
//

import SwiftUI

struct WaveShape: Shape {
    var progress: Double
    
    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let waveHeight: CGFloat = 15
        let frequency: CGFloat = 1.5
        let progressHeight = rect.height * (1 - CGFloat(progress))
        
        // Start from bottom left
        path.move(to: CGPoint(x: 0, y: rect.height))
        
        // Draw bottom line
        path.addLine(to: CGPoint(x: 0, y: progressHeight))
        
        // Draw wave with animation (using progress for phase)
        let step: CGFloat = 2
        for x in stride(from: 0, through: rect.width, by: step) {
            let relativeX = x / rect.width
            // Use progress for animated wave effect
            let phase = CGFloat(progress) * .pi * 2
            let wave = sin(relativeX * frequency * .pi * 2 + phase) * waveHeight
            let y = progressHeight + wave
            
            if x == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        // Complete the shape
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        
        return path
    }
}
