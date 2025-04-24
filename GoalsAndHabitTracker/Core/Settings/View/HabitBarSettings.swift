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
    @State var barStyle1: Bool = true
    @State var barStyle2: Bool = false
    @State var barStyle3: Bool = false
    @State var barStyle4: Bool = false
    @State var barStyle5: Bool = false
    @State var barStyle6: Bool = false

    
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
                
                //Content
                
                HStack {
                    ZStack(alignment: .leading) {
                        GeometryReader { geometry in
                            let width = geometry.size.width
                            let height = geometry.size.height
                            
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.mint.opacity(1))
                                .frame(width: width * (0.7), height: height)
                        }
                        
                        HStack {
                            Text("👑")
                                .font(.title)
                                .padding(8)
                                .background(.mint.opacity(0.3))
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
                    .background(.mint.opacity(0.1))
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
                        barStyle1.toggle()
                        barStyle6 = false
                        barStyle2 = false
                        barStyle3 = false
                        barStyle4 = false
                        barStyle5 = false
                    } label: {
                        if barStyle1 {
                            Image(systemName: "checkmark")
                                .frame(width: UIScreen.main.bounds.width * 0.1 , height: 40)
                                .foregroundStyle(.white)
                                .background(.mint)
                                .clipShape(Circle())
                                .padding()
                                
                                
                                
                            
                        }else{
                            Circle()
                                .stroke(lineWidth: 2)
                                .frame(width: UIScreen.main.bounds.width * 0.1)
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
                                .fill(.mint.opacity(0.4))
                                .frame(width: width * (0.8), height: height)
                        }
                        
                        HStack {
                            Text("👑")
                                .font(.title)
                                .padding(8)
                                .background(.mint.opacity(0.3))
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
                    .background(.mint.opacity(0.1))
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
                        barStyle2.toggle()
                        barStyle1 = false
                        barStyle6 = false
                        barStyle3 = false
                        barStyle4 = false
                        barStyle5 = false
                    } label: {
                        if barStyle2 {
                            Image(systemName: "checkmark")
                                .frame(width: UIScreen.main.bounds.width * 0.1 , height: 40)
                                .foregroundStyle(.white)
                                .background(.mint)
                                .clipShape(Circle())
                                .padding()
                                
                                
                                
                            
                        }else{
                            Circle()
                                .stroke(lineWidth: 2)
                                .frame(width: UIScreen.main.bounds.width * 0.1)
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
                                .fill(.mint.opacity(0.8))
                                .frame(width: width * (0.8), height: height * 0.1)
                        }
                        
                        HStack {
                            Text("👑")
                                .font(.title)
                                .padding(8)
                                .background(.mint.opacity(0.3))
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
                    .background(.mint.opacity(0.1))
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
                        barStyle3.toggle()
                        barStyle1 = false
                        barStyle2 = false
                        barStyle6 = false
                        barStyle4 = false
                        barStyle5 = false
                    } label: {
                        if barStyle3 {
                            Image(systemName: "checkmark")
                                .frame(width: UIScreen.main.bounds.width * 0.1 , height: 40)
                                .foregroundStyle(.white)
                                .background(.mint)
                                .clipShape(Circle())
                                .padding()
                                
                                
                                
                            
                        }else{
                            Circle()
                                .stroke(lineWidth: 2)
                                .frame(width: UIScreen.main.bounds.width * 0.1)
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
                                .fill(.mint.opacity(1))
                                .frame(width: width * (0.034), height: height)
                        }
                        
                        HStack {
                            Text("👑")
                                .font(.title)
                                .padding(8)
                                .background(.mint.opacity(0.3))
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
                    .background(.mint.opacity(0.1))
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
                        barStyle4.toggle()
                        barStyle1 = false
                        barStyle2 = false
                        barStyle3 = false
                        barStyle6 = false
                        barStyle5 = false
                    } label: {
                        if barStyle4 {
                            Image(systemName: "checkmark")
                                .frame(width: UIScreen.main.bounds.width * 0.1 , height: 40)
                                .foregroundStyle(.white)
                                .background(.mint)
                                .clipShape(Circle())
                                .padding()
                                
                                
                                
                            
                        }else{
                            Circle()
                                .stroke(lineWidth: 2)
                                .frame(width: UIScreen.main.bounds.width * 0.1)
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
                                .fill(.mint.opacity(0))
                                .frame(width: width * (0.8), height: height)
                        }
                        
                        HStack {
                            Text("👑")
                                .font(.title)
                                .padding(8)
                                .background(.mint.opacity(0.3))
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
                    .background(.mint.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke( .mint ,lineWidth: 2)
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
                        barStyle5.toggle()
                        barStyle1 = false
                        barStyle2 = false
                        barStyle3 = false
                        barStyle4 = false
                        barStyle6 = false
                    } label: {
                        if barStyle5 {
                            Image(systemName: "checkmark")
                                .frame(width: UIScreen.main.bounds.width * 0.1 , height: 40)
                                .foregroundStyle(.white)
                                .background(.mint)
                                .clipShape(Circle())
                                .padding()
                                
                                
                                
                            
                        }else{
                            Circle()
                                .stroke(lineWidth: 2)
                                .frame(width: UIScreen.main.bounds.width * 0.1)
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
                                .fill(.mint.opacity(0))
                                .frame(width: width * (0.8), height: height)
                        }
                        
                        HStack {
                            Text("👑")
                                .font(.title)
                                .padding(8)
                                .background(.mint.opacity(0.3))
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
                    .background(.mint.opacity(0.1))
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
                        barStyle6.toggle()
                        barStyle1 = false
                        barStyle2 = false
                        barStyle3 = false
                        barStyle4 = false
                        barStyle5 = false
                    } label: {
                        if barStyle6 {
                            Image(systemName: "checkmark")
                                .frame(width: UIScreen.main.bounds.width * 0.1 , height: 40)
                                .foregroundStyle(.white)
                                .background(.mint)
                                .clipShape(Circle())
                                .padding()
                                
                                
                                
                            
                        }else{
                            Circle()
                                .stroke(lineWidth: 2)
                                .frame(width: UIScreen.main.bounds.width * 0.1)
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
}
