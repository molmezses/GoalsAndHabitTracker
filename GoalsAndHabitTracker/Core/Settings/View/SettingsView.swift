//
//  SettingsView.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 22.04.2025.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss

    
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
                    
                    Text("Settings")
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
                
                Spacer()
                
                ZStack {
                    Color(.systemGroupedBackground).ignoresSafeArea()
                    
                    ScrollView {
                        VStack {
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
                            .background(.green.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.horizontal)
                            .fontDesign(.rounded)
                            
                            Text("Account")
                                .font(.caption)
                                .fontDesign(.rounded)
                                .frame(maxWidth: .infinity , alignment: .leading)
                                .padding(.leading)
                                .padding(.vertical , 4)
                            NavigationLink {
                                ProfileView()
                                    .navigationBarBackButtonHidden()
                            } label: {
                                ButtonBar(title: "Account", color: .mint, icon: "person")
                            }
                            .foregroundStyle(.black)

                                
                            Text("App Settings")
                                .font(.caption)
                                .fontDesign(.rounded)
                                .frame(maxWidth: .infinity , alignment: .leading)
                                .padding(.leading)
                                .padding(.vertical , 4)
                            ButtonBar(title: "Language", color: .yellow, icon: "textformat")
                            ButtonBar(title: "Dark Mode", color: .purple, icon: "moon.circle")
                            NavigationLink {
                                HabitBarSettings()
                                    .navigationBarBackButtonHidden()
                            } label: {
                                ButtonBar(title: "Customize Habit Bar", color: .green, icon: "menucard.fill")
                            }
                            .foregroundStyle(.black)

                            Text("General")
                                .font(.caption)
                                .fontDesign(.rounded)
                                .frame(maxWidth: .infinity , alignment: .leading)
                                .padding(.leading)
                                .padding(.vertical , 4)
                            ButtonBar(title: "Give us a happy 5 star!", color: .yellow, icon: "star.fill")
                            ButtonBar(title: "Invite firends", color: .blue, icon: "person.2.fill")
                            ButtonBar(title: "Request a feature", color: .pink, icon: "questionmark.bubble.fill")
                            ButtonBar(title: "Contact Support", color: .indigo, icon: "envelope.fill")
                            ButtonBar(title: "FAQ", color: .orange, icon: "text.page.badge.magnifyingglass")
                            Spacer()
                            
                            Text("Habit Tracker v1.0.0")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                                .padding(.vertical ,6)
                            Text("Made with ☕️ and by 💻Mustafa Olmezses")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                            
                        }//contnt v
                        .padding(.vertical)
                        .padding(.top)

                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(HabitBarSettingsViewModel())
}


