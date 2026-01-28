//
//  HabitBarSettings.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 23.04.2025.
//

import SwiftUI



struct HabitBarSettings: View {
    
    @Environment(\.dismiss) var dismiss
    @State var animate: Bool = false
    @EnvironmentObject var viewModel: HabitBarSettingsViewModel

    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading) {
                // Header
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.secondary)
                            .padding(8)
                            .clipShape(Circle())
                    }

                    Spacer()
                    
                    Text("Select Habir Bar Style")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                        // settings or edit action
                    } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding(8)
                            .clipShape(Circle())
                    }
                }
                .padding()
                
            }
            
            ScrollView {
                //Content
                
                Divider()
                
                Text("Default Style")
                    .font(.title2)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .padding(.leading)
                    .padding(.leading)
                    .fontDesign(.rounded)
                
                
                HStack {
                    ZStack(alignment: .leading) {
                        HStack {
                            Text("👑")
                                .font(.title)
                                .padding(8)
                                .background(.indigo.opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            VStack(spacing: 8) {
                                Text("Drink a water")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                HStack{
                                    Text("\(Int(34))/\(Int(50)) healthy")
                                        .font(.footnote)
                                    Text("|")
                                    Image(systemName: "clock")
                                        .font(.footnote)
                                    Text("14.23")
                                        .font(.footnote)
                                    Spacer()

                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.black)

                            }
                            .padding(.vertical)
                            .fontDesign(.rounded)
                            
                            Spacer()
                            
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemBackground))
                    .frame(width:UIScreen.main.bounds.width * 0.7,height: 80)
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
                    
                    
                    Button {
                        viewModel.barStyle = .barstyle1

                    } label: {
                        if viewModel.barStyle == .barstyle1 {
                            Circle()
                                .frame(width: 30)
                                .padding(.trailing)
                                .foregroundStyle(.green)
                                .padding(.leading)
                        }else{
                            Circle()
                                .stroke(lineWidth: 2)
                                .frame(width: 30)
                                .padding(.trailing)
                                .foregroundStyle(.secondary)
                                .padding(.leading)
                        }
                    }
                        
                }
                .background(Color(.systemGroupedBackground))
                
                Divider()
                    .padding()
                Text("Progress Bar Active 📊")
                    .font(.title2)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .padding(.leading)
                    .padding(.leading)
                    .fontDesign(.rounded)
                    
               
                
                HStack {
                    ZStack(alignment: .leading) {
                        GeometryReader { geometry in
                            let width = geometry.size.width
                            let height = geometry.size.height
                            
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.indigo.opacity(0.6))
                                .frame(width: width * (0.8), height: height)
                        }
                        
                        HStack {
                            Text("👑")
                                .font(.title)
                                .padding(8)
                                .background(.indigo.opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            VStack(spacing: 8) {
                                Text("Drink a water")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                HStack{
                                    Text("\(Int(34))/\(Int(50)) healthy")
                                        .font(.footnote)
                                    Text("|")
                                    Image(systemName: "clock")
                                        .font(.footnote)
                                    Text("14.23")
                                        .font(.footnote)
                                    Spacer()

                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.black)

                            }
                            .padding(.vertical)
                            .fontDesign(.rounded)
                            
                            Spacer()
                            
                            
                        }
                        .padding(.horizontal)
                    }
                    .frame(width:UIScreen.main.bounds.width * 0.7,height: 80)
                    .background(.indigo.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .opacity(animate ? 1 : 0)
                    .offset(y: animate ? 0 : 20)
                    .animation(.easeInOut(duration: 0.6), value: animate)
                    .onAppear {
                        animate = true
                    }
                    
                    Button {
                        viewModel.barStyle = .barstyle2

                    } label: {
                        if viewModel.barStyle == .barstyle2 {
                            Circle()
                                .frame(width: 30)
                                .padding(.trailing)
                                .foregroundStyle(.green)
                                .padding(.leading)
                        }else{
                            Circle()
                                .stroke(lineWidth: 2)
                                .frame(width: 30)
                                .padding(.trailing)
                                .foregroundStyle(.secondary)
                                .padding(.leading)
                        }
                    }
                }
                
                
                HStack {
                    ZStack(alignment: .leading) {
                        GeometryReader { geometry in
                            let width = geometry.size.width
                            let height = geometry.size.height
                            
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.indigo.opacity(0.8))
                                .frame(width: width * (0.8), height: height * 0.1)
                        }
                        
                        HStack {
                            Text("👑")
                                .font(.title)
                                .padding(8)
                                .background(.indigo.opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            VStack(spacing: 8) {
                                Text("Drink a water")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                HStack{
                                    Text("\(Int(34))/\(Int(50)) healthy")
                                        .font(.footnote)
                                    Text("|")
                                    Image(systemName: "clock")
                                        .font(.footnote)
                                    Text("14.23")
                                        .font(.footnote)
                                    Spacer()

                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.black)

                            }
                            .padding(.vertical)
                            .fontDesign(.rounded)
                            
                            Spacer()
                            
                           
                        }
                        .padding(.horizontal)
                    }
                    .frame(width:UIScreen.main.bounds.width * 0.7,height: 80)
                    .background(.indigo.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .opacity(animate ? 1 : 0)
                    .offset(y: animate ? 0 : 20)
                    .animation(.easeInOut(duration: 0.6), value: animate)
                    .onAppear {
                        animate = true
                    }
                    
                    Button {
                        viewModel.barStyle = .barstyle3

                    } label: {
                        if viewModel.barStyle == .barstyle3 {
                            Circle()
                                .frame(width: 30)
                                .padding(.trailing)
                                .foregroundStyle(.green)
                                .padding(.leading)
                        }else{
                            Circle()
                                .stroke(lineWidth: 2)
                                .frame(width: 30)
                                .padding(.trailing)
                                .foregroundStyle(.secondary)
                                .padding(.leading)
                        }
                    }
                    
                }
                Divider()
                    .padding()
                Text("Progress Bar Inactive ❌")
                    .font(.title2)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .padding(.leading)
                    .padding(.leading)
                
                HStack {
                    ZStack(alignment: .leading) {
                        GeometryReader { geometry in
                            let width = geometry.size.width
                            let height = geometry.size.height
                            
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.indigo.opacity(0))
                                .frame(width: width * (0.8), height: height)
                        }
                        
                        HStack {
                            Text("👑")
                                .font(.title)
                                .padding(8)
                                .background(.indigo.opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            VStack(spacing: 8) {
                                Text("Drink a water")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                HStack{
                                    Text("\(Int(34))/\(Int(50)) healthy")
                                        .font(.footnote)
                                    Text("|")
                                    Image(systemName: "clock")
                                        .font(.footnote)
                                    Text("14.23")
                                        .font(.footnote)
                                    Spacer()

                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.black)

                            }
                            .padding(.vertical)
                            .fontDesign(.rounded)
                            
                            Spacer()
                            
                            
                        }
                        .padding(.horizontal)
                    }
                    .frame(width:UIScreen.main.bounds.width * 0.7,height: 80)
                    .background(.indigo.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke( .indigo ,lineWidth: 2)
                    )
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    
                    .opacity(animate ? 1 : 0)
                    .offset(y: animate ? 0 : 20)
                    .animation(.easeInOut(duration: 0.6), value: animate)
                    .onAppear {
                        animate = true
                    }
                    
                    Button {
                        viewModel.barStyle = .barstyle4

                    } label: {
                        if viewModel.barStyle == .barstyle4 {
                            Circle()
                                .frame(width: 30)
                                .padding(.trailing)
                                .foregroundStyle(.green)
                                .padding(.leading)
                        }else{
                            Circle()
                                .stroke(lineWidth: 2)
                                .frame(width: 30)
                                .padding(.trailing)
                                .foregroundStyle(.secondary)
                                .padding(.leading)
                        }
                    }
                }
                
                
                HStack {
                    ZStack(alignment: .leading) {
                        GeometryReader { geometry in
                            let width = geometry.size.width
                            let height = geometry.size.height
                            
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.indigo.opacity(1))
                                .frame(width: width * (0.034), height: height)
                        }
                        
                        HStack {
                            Text("👑")
                                .font(.title)
                                .padding(8)
                                .background(.indigo.opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            VStack(spacing: 8) {
                                Text("Drink a water")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                HStack{
                                    Text("\(Int(34))/\(Int(50)) healthy")
                                        .font(.footnote)
                                    Text("|")
                                    Image(systemName: "clock")
                                        .font(.footnote)
                                    Text("14.23")
                                        .font(.footnote)
                                    Spacer()

                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.black)

                            }
                            .padding(.vertical)
                            .fontDesign(.rounded)
                            
                            Spacer()
                            
                        }
                        .padding(.horizontal)
                    }
                    .frame(width:UIScreen.main.bounds.width * 0.7,height: 80)
                    .background(.indigo.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .opacity(animate ? 1 : 0)
                    .offset(y: animate ? 0 : 20)
                    .animation(.easeInOut(duration: 0.6), value: animate)
                    .onAppear {
                        animate = true
                    }
                    
                    Button {
                        viewModel.barStyle = .barstyle5

                    } label: {
                        if viewModel.barStyle == .barstyle5 {
                            Circle()
                                .frame(width: 30)
                                .padding(.trailing)
                                .foregroundStyle(.green)
                                .padding(.leading)
                        }else{
                            Circle()
                                .stroke(lineWidth: 2)
                                .frame(width: 30)
                                .padding(.trailing)
                                .foregroundStyle(.secondary)
                                .padding(.leading)
                        }
                    }
                        
                }
                
                HStack {
                    ZStack(alignment: .leading) {
                        GeometryReader { geometry in
                            let width = geometry.size.width
                            let height = geometry.size.height
                            
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.indigo.opacity(0))
                                .frame(width: width * (0.8), height: height)
                        }
                        
                        HStack {
                            Text("👑")
                                .font(.title)
                                .padding(8)
                                .background(.indigo.opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            VStack(spacing: 8) {
                                Text("Drink a water")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                HStack{
                                    Text("\(Int(34))/\(Int(50)) healthy")
                                        .font(.footnote)
                                    Text("|")
                                    Image(systemName: "clock")
                                        .font(.footnote)
                                    Text("14.23")
                                        .font(.footnote)
                                    Spacer()

                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.black)

                            }
                            .padding(.vertical)
                            .fontDesign(.rounded)
                            
                            Spacer()
                            
                            
                        }
                        .padding(.horizontal)
                    }
                    .frame(width:UIScreen.main.bounds.width * 0.7,height: 80)
                    .background(.indigo.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke( .indigo ,lineWidth: 2)
                    )
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    
                    .opacity(animate ? 1 : 0)
                    .offset(y: animate ? 0 : 20)
                    .animation(.easeInOut(duration: 0.6), value: animate)
                    .onAppear {
                        animate = true
                    }
                    
                    Button {
                        viewModel.barStyle = .barstyle6

                    } label: {
                        if viewModel.barStyle == .barstyle6 {
                            Circle()
                                .frame(width: 30)
                                .padding(.trailing)
                                .foregroundStyle(.green)
                                .padding(.leading)
                        }else{
                            Circle()
                                .stroke(lineWidth: 2)
                                .frame(width: 30)
                                .padding(.trailing)
                                .foregroundStyle(.secondary)
                                .padding(.leading)
                        }
                    }
                }
                
                Divider()
                    .padding()
                Text("Modern Styles 🎨")
                    .font(.title2)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .padding(.leading)
                    .padding(.leading)
                
                // Style 7: Card with Shadow
                HStack {
                    ZStack(alignment: .leading) {
                        HStack {
                            Text("👑")
                                .font(.title)
                                .padding(8)
                                .background(.indigo.opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            VStack(spacing: 8) {
                                Text("Drink a water")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                HStack{
                                    Text("\(Int(34))/\(Int(50)) healthy")
                                        .font(.footnote)
                                    Text("|")
                                    Image(systemName: "clock")
                                        .font(.footnote)
                                    Text("14.23")
                                        .font(.footnote)
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.black)
                            }
                            .padding(.vertical)
                            .fontDesign(.rounded)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    .frame(width:UIScreen.main.bounds.width * 0.7,height: 80)
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .indigo.opacity(0.3), radius: 8, x: 0, y: 4)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .opacity(animate ? 1 : 0)
                    .offset(y: animate ? 0 : 20)
                    .animation(.easeInOut(duration: 0.6), value: animate)
                    .onAppear {
                        animate = true
                    }
                    
                    Button {
                        viewModel.barStyle = .barstyle7
                    } label: {
                        if viewModel.barStyle == .barstyle7 {
                            Circle()
                                .frame(width: 30)
                                .padding(.trailing)
                                .foregroundStyle(.green)
                                .padding(.leading)
                        }else{
                            Circle()
                                .stroke(lineWidth: 2)
                                .frame(width: 30)
                                .padding(.trailing)
                                .foregroundStyle(.secondary)
                                .padding(.leading)
                        }
                    }
                }
                
                // Style 8: Gradient Progress
                HStack {
                    ZStack(alignment: .leading) {
                        GeometryReader { geometry in
                            LinearGradient(
                                colors: [.indigo, .indigo.opacity(0.6)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height)
                        }
                        
                        HStack {
                            Text("👑")
                                .font(.title)
                                .padding(8)
                                .background(.indigo.opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            VStack(spacing: 8) {
                                Text("Drink a water")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                HStack{
                                    Text("\(Int(34))/\(Int(50)) healthy")
                                        .font(.footnote)
                                    Text("|")
                                    Image(systemName: "clock")
                                        .font(.footnote)
                                    Text("14.23")
                                        .font(.footnote)
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.black)
                            }
                            .padding(.vertical)
                            .fontDesign(.rounded)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    .frame(width:UIScreen.main.bounds.width * 0.7,height: 80)
                    .background(.indigo.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .opacity(animate ? 1 : 0)
                    .offset(y: animate ? 0 : 20)
                    .animation(.easeInOut(duration: 0.6), value: animate)
                    .onAppear {
                        animate = true
                    }
                    
                    Button {
                        viewModel.barStyle = .barstyle8
                    } label: {
                        if viewModel.barStyle == .barstyle8 {
                            Circle()
                                .frame(width: 30)
                                .padding(.trailing)
                                .foregroundStyle(.green)
                                .padding(.leading)
                        }else{
                            Circle()
                                .stroke(lineWidth: 2)
                                .frame(width: 30)
                                .padding(.trailing)
                                .foregroundStyle(.secondary)
                                .padding(.leading)
                        }
                    }
                }
                
                // Style 9: Compact Minimal
                HStack {
                    HStack(spacing: 12) {
                        Text("👑")
                            .font(.title2)
                            .frame(width: 40, height: 40)
                            .background(.indigo.opacity(0.2))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Drink a water")
                                .font(.headline)
                                .lineLimit(1)
                            
                            HStack(spacing: 4) {
                                Text("34/50")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                Circle()
                                    .fill(.indigo)
                                    .frame(width: 4, height: 4)
                                
                                Text("14.23")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        Spacer()
                        
                        Circle()
                            .fill(.indigo.opacity(0.3))
                            .frame(width: 24, height: 24)
                            .overlay(
                                Circle()
                                    .trim(from: 0, to: 0.68)
                                    .stroke(.indigo, lineWidth: 2)
                                    .rotationEffect(.degrees(-90))
                            )
                    }
                    .padding(12)
                    .frame(width:UIScreen.main.bounds.width * 0.7,height: 70)
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
                    
                    Button {
                        viewModel.barStyle = .barstyle9
                    } label: {
                        if viewModel.barStyle == .barstyle9 {
                            Circle()
                                .frame(width: 30)
                                .padding(.trailing)
                                .foregroundStyle(.green)
                                .padding(.leading)
                        }else{
                            Circle()
                                .stroke(lineWidth: 2)
                                .frame(width: 30)
                                .padding(.trailing)
                                .foregroundStyle(.secondary)
                                .padding(.leading)
                        }
                    }
                }
               
                Spacer()
            }

            
            
        }
    }

}

#Preview {
    HabitBarSettings()
        .environmentObject(HabitBarSettingsViewModel())
}
