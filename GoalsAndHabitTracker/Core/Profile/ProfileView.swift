//
//  ProfileView.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 22.04.2025.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showLogin = false
    @State private var showRegister = false
    @State private var showForgotPassword = false
    @State private var animate = false
    @State private var name: String = UserDefaults.standard.string(forKey: "userName") ?? ""
    @StateObject private var viewModel = ProfileViewModel()
    @State private var showImagePicker = false
    @State private var profileImage: UIImage? = nil



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
                    Text("Profile")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    
                    // kaldırıldı: ayarlar butonu
                }
                .padding()
                .background(Color.white)

                ZStack {
                    Color(.systemGroupedBackground).ignoresSafeArea()
                    
                    ScrollView {
                        VStack(spacing: 24) {
                            Image(uiImage: viewModel.profileImage ?? UIImage(named: "logo")!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .padding(.top)
                                .onTapGesture {
                                    showImagePicker = true
                                }
                                .overlay(alignment: .bottomTrailing) {
                                    Image(systemName: "plus")
                                        .padding(8)
                                        .background(Color(.systemGray3))
                                        .clipShape(Circle())
                                        .foregroundStyle(.white)
                                }
                            
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Name")
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.black)
                                
                                TextField("Guest...", text: $name)
                                    .padding()
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .onChange(of: name) {newValue in
                                        UserDefaults.standard.set(newValue, forKey: "userName")
                                    }

                                
                                HStack {
                                    Spacer()
                                    Text("0/30")
                                        .font(.footnote)
                                        .foregroundStyle(.gray)
                                }
                            }
                            .padding(.horizontal)
                            
//                            VStack(alignment: .leading, spacing: 12) {
//                                Text("Account")
//                                    .font(.headline)
//                                    .padding(.leading)
//
//                                NavigationLink(destination: EmptyView()) {
//                                    profileRow(icon: "person.fill", color: .mint, title: "Log In", isNavLink: true)
//                                }
//
//                                NavigationLink(destination: EmptyView()) {
//                                    profileRow(icon: "envelope.fill", color: .orange, title: "Register", isNavLink: true)
//                                }
//
//                                NavigationLink(destination: EmptyView()) {
//                                    profileRow(icon: "key.horizontal.fill", color: .pink, title: "Forgot Password?", isNavLink: true)
//                                }
//                                
//                            }
//                            .foregroundStyle(.black)


                            VStack(alignment: .leading, spacing: 12) {
                                Text("App Info")
                                    .font(.headline)
                                    .padding(.leading)

                                profileRow(icon: "info.circle.fill", color: .blue, title: "App Version: 1.0.0", isNavLink: false)
                                profileRow(icon: "doc.plaintext.fill", color: .gray, title: "Terms and Conditions" ,isNavLink: false)
                            }

                            VStack(alignment: .leading, spacing: 12) {
                                Text("Clear All Data")
                                    .font(.headline)
                                    .padding(.leading)

                                profileRow(icon: "trash.fill", color: .red, title: "Reset All Habits", isNavLink: false)
                            }
                        }
                        .padding(.bottom)
                    }
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker { image in
                    if let selected = image {
                        viewModel.saveProfileImage(selected)
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

    func profileRow(icon: String, color: Color, title: String , isNavLink : Bool) -> some View {
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
            if isNavLink{
                Image(systemName: "chevron.right")
            }
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


