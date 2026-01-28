//
//  AddHabitButtonBar.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 22.04.2025.
//

import SwiftUI

struct AddHabitButtonBar: View {
    
    @State var title: String
    @State var color: Color
    @State var icon : String
    @State var animate : Bool = false

    
    var body: some View {
        
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 40, height: 40)
                .foregroundStyle(color.opacity(0.4))
                .overlay {
                    Text(icon)
                        .font(.title)
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
        
    }
}

#Preview {
    AddHabitButtonBar(title: "lorem ipsum", color: .green, icon: "🏝️")
}
