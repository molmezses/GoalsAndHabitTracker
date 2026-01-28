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
    @EnvironmentObject var soundVM : SoundViewModel

    
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
                            .foregroundColor(.secondary)
                            .padding(8)
                            .background(Color(.systemBackground))
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
                            .background(Color(.systemBackground))
                            .clipShape(Circle())
                    }
                }
                .padding()
                .background(Color.white)
                
                Spacer()
                
                ZStack {
                    Color(.systemGroupedBackground)
                        .ignoresSafeArea(edges: .bottom)
                    
                    ScrollView {
                        VStack {
                            
                            Button {
                                soundVM.selectedSound = "s1"
                                SoundManager.instance.playSound(sound: soundVM.selectedSound)
                            } label: {
                                HStack {
                                    Text("Sound 1")
                                    Spacer()
                                    if soundVM.selectedSound == "Sound 1" || soundVM.selectedSound == "s1"{
                                        Image(systemName: "checkmark")
                                    }
                                }
                                .modifier(SelectSoundModifier())

                            }
                            
                            Button {
                                soundVM.selectedSound = "s2"
                                SoundManager.instance.playSound(sound: soundVM.selectedSound)
                            } label: {
                                HStack {
                                    Text("Sound 2")
                                    Spacer()
                                    if soundVM.selectedSound == "s2"{
                                        Image(systemName: "checkmark")
                                    }
                                }
                                .modifier(SelectSoundModifier())

                            }
                            
                            Button {
                                soundVM.selectedSound = "s3"
                                SoundManager.instance.playSound(sound: soundVM.selectedSound)
                            } label: {
                                HStack {
                                    Text("Sound 3")
                                    Spacer()
                                    if soundVM.selectedSound == "s3"{
                                        Image(systemName: "checkmark")
                                    }
                                }
                                .modifier(SelectSoundModifier())

                            }
                            
                            Button {
                                soundVM.selectedSound = "s4"
                                SoundManager.instance.playSound(sound: soundVM.selectedSound)
                            } label: {
                                HStack {
                                    Text("Sound 4")
                                    Spacer()
                                    if soundVM.selectedSound == "s4"{
                                        Image(systemName: "checkmark")
                                    }
                                }
                                .modifier(SelectSoundModifier())
                            }
                            
                            Button {
                                soundVM.selectedSound = "s5"
                                SoundManager.instance.playSound(sound: soundVM.selectedSound)
                            } label: {
                                HStack {
                                    Text("Sound 5")
                                    Spacer()
                                    if soundVM.selectedSound == "s5"{
                                        Image(systemName: "checkmark")
                                    }
                                }
                                .modifier(SelectSoundModifier())
                            }
                            
                            Button {
                                soundVM.selectedSound = "s6"
                                SoundManager.instance.playSound(sound: soundVM.selectedSound)
                            } label: {
                                HStack {
                                    Text("Sound 6")
                                    Spacer()
                                    if soundVM.selectedSound == "s6"{
                                        Image(systemName: "checkmark")
                                    }
                                }
                                .modifier(SelectSoundModifier())

                            }
                            
                            Button {
                                soundVM.selectedSound = "s7"
                                SoundManager.instance.playSound(sound: soundVM.selectedSound)
                            } label: {
                                HStack {
                                    Text("Sound 7")
                                    Spacer()
                                    if soundVM.selectedSound == "s7"{
                                        Image(systemName: "checkmark")
                                    }
                                }
                                .modifier(SelectSoundModifier())
                            }
                            
                            Button {
                                soundVM.selectedSound = "s8"
                                SoundManager.instance.playSound(sound: soundVM.selectedSound)
                            } label: {
                                HStack {
                                    Text("Sound 8")
                                    Spacer()
                                    if soundVM.selectedSound == "s8"{
                                        Image(systemName: "checkmark")
                                    }
                                }
                                .modifier(SelectSoundModifier())
                                
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

struct SelectSoundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .padding(12)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .padding(.horizontal)
            .fontDesign(.rounded)
            .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: 1)
    }
}



#Preview {
    SelectSoundView()
        .environmentObject(SoundViewModel())
}
