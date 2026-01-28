//
//  ButtonBar.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 22.04.2025.
//

import SwiftUI

struct ButtonBar: View {
    
    @State var title: String
    @State var color: Color
    @State var icon : String
    @State var animate : Bool = false

    
    var body: some View {
        
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 32, height: 32)
                .foregroundStyle(color)
                .overlay {
                    Image(systemName: icon)
                        .foregroundStyle(.white)
                }
            
            Text(title)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding(12)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
        .fontDesign(.rounded)
        .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: 1)
        .opacity(animate ? 1 : 0)
        .offset(y: animate ? 0 : 20)
        .animation(.easeInOut(duration: 0.6), value: animate)
        .onAppear {
            animate = true
        }
    }
}

#Preview {
    ButtonBar(title: "lorem ipsum", color: .green, icon: "person")
}
