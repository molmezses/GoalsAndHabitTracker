//
//  SelectSoundView.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 1.05.2025.
//


import SwiftUI

struct SelectSoundView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var animate: Bool = false
    @EnvironmentObject var viewModel : SoundViewModel

    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .padding(8)
                            .background(Color.white)
                            .clipShape(Circle())
                    }

                    Spacer()
                    
                    Text("Select a sound")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                                            } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                }
                .padding()
                .background(Color.white)
                
                Spacer()
                
                ZStack {
                    Color(.systemGroupedBackground).ignoresSafeArea()
                    
                    ScrollView {
                        VStack {
                            
                            SoundBarView(title: "Drink Water", color: .blue, icon: "🎶", isSelected: viewModel.soundBar == .sound1) {
                                viewModel.soundBar = .sound1
                            }
                            .opacity(animate ? 1 : 0)
                            .offset(y: animate ? 0 : 20)
                            .animation(.easeInOut(duration: 0.4), value: animate)
                            .onAppear {
                                animate = true
                            }
                            .onTapGesture {
                                viewModel.soundBar = .sound1
                            }
                            
                            SoundBarView(title: "Sound 2", color: .green, icon: "🎶", isSelected: viewModel.soundBar == .sound2) {
                                viewModel.soundBar = .sound2
                            }
                            .opacity(animate ? 1 : 0)
                            .offset(y: animate ? 0 : 20)
                            .animation(.easeInOut(duration: 0.4), value: animate)
                            .onAppear {
                                animate = true
                            }
                            .onTapGesture {
                                viewModel.soundBar = .sound2
                            }
                            
                            SoundBarView(title: "Sound 3", color: .green, icon: "🎶", isSelected: viewModel.soundBar == .sound3) {
                                viewModel.soundBar = .sound3
                            }
                            .opacity(animate ? 1 : 0)
                            .offset(y: animate ? 0 : 20)
                            .animation(.easeInOut(duration: 0.4), value: animate)
                            .onAppear {
                                animate = true
                            }
                            .onTapGesture {
                                viewModel.soundBar = .sound3
                            }

                        }//contnt v
                        .padding(.vertical)
                        .padding(.top , 4)
                        .opacity(animate ? 1 : 0)
                        .offset(y: animate ? 0 : 20)
                        .animation(.easeInOut(duration: 0.6), value: animate)
                        .onAppear {
                            animate = true
                        }
                    }
                }
            }
        }
    }
}



#Preview {
    SelectSoundView()
        .environmentObject(SoundViewModel())
}
