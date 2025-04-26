//
//  ProfileView.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 22.04.2025.
//
import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State var name: String = ""
    @State private var animate = false

    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
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
                    
                    Text("Account")
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
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                }
                .padding()
                .background(Color.white)
                
                // Scrollable Content
                ZStack {
                    Color(.systemGroupedBackground).ignoresSafeArea()
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            
                            // Profile Image
                            Image("logo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .overlay(alignment: .bottomTrailing) {
                                    Image(systemName: "plus")
                                        .padding(8)
                                        .background(Color(.systemGray3))
                                        .clipShape(Circle())
                                        .foregroundStyle(.white)
                                }
                            
                            // Name Field
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Name")
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.black)
                                
                                TextField("Guest...", text: $name)
                                    .padding()
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                
                                HStack {
                                    Spacer()
                                    Text("0/30")
                                        .font(.footnote)
                                        .foregroundStyle(.gray)
                                }
                            }
                            .padding(.horizontal)
                            
                            // Actions
                            VStack(spacing: 12) {
                                profileRow(icon: "person.fill", color: .mint, title: "Login your account")
                                profileRow(icon: "envelope.fill", color: .orange, title: "Register")
                                profileRow(icon: "key.horizontal.fill", color: .pink, title: "Forget password ?")
                            }
                            
                            // Premium Section
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Premium")
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.black)

                                    .padding(.leading)
                                
                                HStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .frame(width: 32, height: 32)
                                        .foregroundStyle(.green)
                                        .overlay {
                                            Image(systemName: "star.fill")
                                                .foregroundStyle(.white)
                                        }
                                    
                                    Text("Upgrade to Premium")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.gray)
                                }
                                .padding(12)
                                .background(.green.opacity(0.4))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .padding(.horizontal)
                                .fontDesign(.rounded)
                                
                            }
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Log out")
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.black)
                                    .foregroundStyle(.black)
                                    .padding(.leading)
                                
                                HStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .frame(width: 32, height: 32)
                                        .foregroundStyle(.red)
                                        .overlay {
                                            Image(systemName: "chevron.right")
                                                .foregroundStyle(.white)
                                        }
                                    
                                    Text("Log out")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.gray)
                                }
                                .padding(12)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .padding(.horizontal)
                                .fontDesign(.rounded)
                                
                            }
                        }
                        .padding(.top)
                    }
                }
            }
            .opacity(animate ? 1 : 0)
            .offset(y: animate ? 0 : 20)
            .animation(.easeOut(duration: 0.6), value: animate)
            .onAppear {
                animate = true
            }
        }
    }
    
    // Reusable row
    func profileRow(icon: String, color: Color, title: String) -> some View {
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
                .foregroundStyle(.gray)
        }
        .padding(12)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
        .fontDesign(.rounded)
        .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: 1)

    }
}

#Preview {
    ProfileView()
}


