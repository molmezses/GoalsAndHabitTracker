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
                            .foregroundColor(.gray)
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
                    .background(.white)
                    .frame(width:UIScreen.main.bounds.width * 0.7,height: 80)
                    .background(.white)
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
                        viewModel.barStyle7.toggle()
                        viewModel.barStyle1 = false
                        viewModel.barStyle2 = false
                        viewModel.barStyle3 = false
                        viewModel.barStyle6 = false
                        viewModel.barStyle5 = false
                        viewModel.barStyle4 = false

                    } label: {
                        if viewModel.barStyle7 {
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
                                .foregroundStyle(.gray)
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
                        viewModel.barStyle2.toggle()
                        viewModel.barStyle1 = false
                        viewModel.barStyle7 = false
                        viewModel.barStyle3 = false
                        viewModel.barStyle6 = false
                        viewModel.barStyle5 = false
                        viewModel.barStyle4 = false

                    } label: {
                        if viewModel.barStyle2 {
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
                                .foregroundStyle(.gray)
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
                        viewModel.barStyle3.toggle()
                        viewModel.barStyle1 = false
                        viewModel.barStyle2 = false
                        viewModel.barStyle7 = false
                        viewModel.barStyle6 = false
                        viewModel.barStyle5 = false
                        viewModel.barStyle4 = false

                    } label: {
                        if viewModel.barStyle3 {
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
                                .foregroundStyle(.gray)
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
                        viewModel.barStyle1.toggle()
                        viewModel.barStyle7 = false
                        viewModel.barStyle2 = false
                        viewModel.barStyle3 = false
                        viewModel.barStyle6 = false
                        viewModel.barStyle5 = false
                        viewModel.barStyle4 = false

                    } label: {
                        if viewModel.barStyle1 {
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
                                .foregroundStyle(.gray)
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
                        viewModel.barStyle4.toggle()
                        viewModel.barStyle1 = false
                        viewModel.barStyle2 = false
                        viewModel.barStyle3 = false
                        viewModel.barStyle6 = false
                        viewModel.barStyle5 = false
                        viewModel.barStyle7 = false

                    } label: {
                        if viewModel.barStyle4 {
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
                                .foregroundStyle(.gray)
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
                        viewModel.barStyle5.toggle()
                        viewModel.barStyle1 = false
                        viewModel.barStyle2 = false
                        viewModel.barStyle3 = false
                        viewModel.barStyle6 = false
                        viewModel.barStyle7 = false
                        viewModel.barStyle4 = false

                    } label: {
                        if viewModel.barStyle5 {
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
                                .foregroundStyle(.gray)
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
