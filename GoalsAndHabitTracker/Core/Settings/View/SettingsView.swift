//
//  SettingsView.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 22.04.2025.
//

import SwiftUI
import MessageUI
import UIKit

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @State var animate: Bool = false
    @State private var isShowingMailView = false
    @State private var mailErrorAlert = false



    
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
                            
                            
                            HStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .frame(width: 32, height: 32)
                                    .foregroundStyle(.orange)
                                    .overlay {
                                        Image(systemName: "textformat")
                                            .foregroundStyle(.white)
                                    }
                                
                                Text("Language")
                                Spacer()
                                Menu {
                                    Button("English"){}
                                } label: {
                                    HStack {
                                        Text("English")
                                            .foregroundColor(.primary)
                                        Image(systemName: "chevron.down")
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.horizontal)
                                    .padding(.vertical, 6)
                                    .background(Color(.systemGray6))
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                }

                            }
                            .padding(12)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.horizontal)
                            .fontDesign(.rounded)
                            .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: 1)
                            .opacity(animate ? 1 : 0)
                            .offset(y: animate ? 0 : 20)
                            .animation(.easeInOut(duration: 0.6), value: animate)
                            .onAppear{
                                animate = true
                            }
                            
                            
                            HStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .frame(width: 32, height: 32)
                                    .foregroundStyle(.orange)
                                    .overlay {
                                        Image(systemName: "moon.circle")
                                            .foregroundStyle(.white)
                                    }
                                
                                Text("Dark Mode")
                                Spacer()
                                Menu {
                                    Button("Light"){}
                                } label: {
                                    HStack {
                                        Text("Light")
                                            .foregroundColor(.primary)
                                        Image(systemName: "chevron.down")
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.horizontal)
                                    .padding(.vertical, 6)
                                    .background(Color(.systemGray6))
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                }

                            }
                            .padding(12)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.horizontal)
                            .fontDesign(.rounded)
                            .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: 1)
                            .opacity(animate ? 1 : 0)
                            .offset(y: animate ? 0 : 20)
                            .animation(.easeInOut(duration: 0.6), value: animate)
                            .onAppear{
                                animate = true
                            }
                            
                            
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
                            Button(action: {
                                shareApp()
                            }) {
                                ButtonBar(title: "Invite friends", color: .blue, icon: "person.2.fill")
                            }
                            .foregroundStyle(.black)

                            ButtonBar(title: "Request a feature", color: .pink, icon: "questionmark.bubble.fill")
                            Button(action: {
                                if MFMailComposeViewController.canSendMail() {
                                    isShowingMailView = true
                                } else {
                                    mailErrorAlert = true
                                }
                            }) {
                                ButtonBar(title: "Contact Support", color: .indigo, icon: "envelope.fill")
                            }
                            .foregroundStyle(.black)
                            .sheet(isPresented: $isShowingMailView) {
                                MailView(recipient: "mustafaolmezses@gmail.com")
                            }
                            .alert("Mail app not configured", isPresented: $mailErrorAlert) {
                                Button("OK", role: .cancel) {}
                            } message: {
                                Text("Please set up a mail account in order to send email.")
                            }

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
    
    func shareApp() {
        let message = """
        I’m using this awesome app to plan my goals and track my daily habits. It’s really helping me stay focused and consistent. You should give it a try too!

        📱 Habit Tracker
        """
        let activityVC = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let root = scene.windows.first?.rootViewController {
            root.present(activityVC, animated: true)
        }
    }
}



#Preview {
    SettingsView()
        .environmentObject(HabitBarSettingsViewModel())
}


