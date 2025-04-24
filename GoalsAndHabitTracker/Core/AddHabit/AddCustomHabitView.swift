//
//  AddCustomHabitView.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 22.04.2025.
//
import SwiftUI

struct AddCustomHabitView: View {
    @State var animate: Bool = false
    @Environment(\.dismiss) var dismiss
    @State var color: Color = .green
    @State var name: String = ""
    @State private var selectedUnit: String = "Seç"
    @State private var targetAmount: String = "" // Yeni: Kullanıcının gireceği değer

    // Gerekli ek state’ler:
    @State private var selectedDays: Set<String> = []
    @State private var reminderTime = Date()
    @State var reminderIsOn: Bool = true
    @State var rapor: Bool = true

    // Haftanın günleri
    let weekDays = ["Pt", "Sa", "Ça", "Pe", "Cu", "Ct", "Pz"]

    // Özel renkler
    let colors: [Color] = [
        Color(hex: "#F0A500"), Color(hex: "#1A535C"), Color(hex: "#FF6B6B"),
        Color(hex: "#FFE66D"), Color(hex: "#4ECDC4"), Color(hex: "#6B4226"),
        Color(hex: "#F7B7A3"), Color(hex: "#E27D60"), Color(hex: "#41B3A3"),
        Color(hex: "#D4E157"), Color(hex: "#8E44AD"), Color(hex: "#F39C12"),
        Color(hex: "#2C3E50"), Color(hex: "#2980B9"), Color(hex: "#1F618D"),
        Color(hex: "#D35400"), Color(hex: "#27AE60"), Color(hex: "#E74C3C"),
        Color(hex: "#34495E"), Color(hex: "#16A085"), Color(hex: "#2ECC71"),
        Color(hex: "#9B59B6"), Color(hex: "#E67E22"), Color(hex: "#ECF0F1"),
        Color(hex: "#3498DB"), Color(hex: "#F1C40F"), Color(hex: "#C0392B")
    ]
    
    @State private var showingColorSheet: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding(8)
                    }

                    Text("✅")
                    Text("Add a custom habit ")
                        .font(.headline)
                        .fontWeight(.bold)

                    Spacer()

                    Button {

                    } label: {
                        Text("Save")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding(6)
                            .background {
                                color
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .padding()
                .background(color.opacity(0.2))

                ZStack {
                    color.opacity(0.2).ignoresSafeArea()

                    ScrollView {
                        VStack(spacing: 16) {
                            // Habit Name Section
                            VStack(spacing: 12) {
                                HStack(spacing: 12) {
                                    Text("✅")
                                        .font(.title)
                                        .padding(12)
                                        .background(color.opacity(0.3))
                                        .clipShape(RoundedRectangle(cornerRadius: 12))

                                    VStack(alignment: .leading) {
                                        TextField("Habit name", text: $name)
                                            .font(.headline)
                                    }

                                    Spacer()
                                }

                                Divider()

                                HStack {
                                    Text("Color")
                                        .font(.subheadline)
                                    Spacer()
                                    Button {
                                        showingColorSheet.toggle()
                                    } label: {
                                        HStack {
                                            RoundedRectangle(cornerRadius: 24)
                                                .frame(width: 36, height: 16)
                                                .foregroundStyle(color)
                                            Image(systemName: "chevron.right")
                                                .foregroundStyle(.gray)
                                        }
                                    }
                                }

                                Divider()

                                HStack {
                                    Text("Emoji")
                                        .font(.subheadline)
                                    Spacer()
                                    Text("👑")
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.gray)
                                }

                                Divider()

                                HStack {
                                    Text("Target Value")
                                        .font(.subheadline)
                                    Spacer()
                                    TextField("100", text: $targetAmount)
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.leading)
                                        .padding(8)
                                        .frame(width: 60)
                                        .background(Color(.systemGray6))
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    Text("/day")
                                        .font(.subheadline)
                                }
                                Divider()

                                HStack {
                                    Text("Select a category")
                                    Spacer()
                                    Menu {
                                           Button("Adet") { selectedUnit = "Adet" }
                                           Button("Sayfa") { selectedUnit = "Sayfa" }
                                           Button("Gün") { selectedUnit = "Gün" }
                                           Button("Kalori") { selectedUnit = "Kalori" }
                                           Button("Litre") { selectedUnit = "Litre" }
                                       } label: {
                                           HStack {
                                               Text(selectedUnit)
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

                                Divider()

                                HStack {
                                    Text("Task Days")
                                    Spacer()
                                    Text("Every Day")
                                }
                                Text("*Complete 1 count each day")
                                    .font(.caption2)
                                    .foregroundColor(.red)
                            }
                            .padding()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding(.horizontal)

                            // Reminder Days and Time Section
                            VStack(alignment: .leading, spacing: 16) {
                                Toggle("Reminders", isOn: $reminderIsOn)
                                    .toggleStyle(SwitchToggleStyle(tint: color))


                                Divider()
                                // Gün Seçimi
                                HStack(spacing: 10) {
                                    ForEach(weekDays, id: \.self) { day in
                                        Text(day)
                                            .font(.caption)
                                            .frame(width: 36, height: 36)
                                            .background(selectedDays.contains(day) ? color.opacity(1) : color.opacity(0.4))
                                            .foregroundColor(selectedDays.contains(day) ? .white : .black)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                            .onTapGesture {
                                                if selectedDays.contains(day) {
                                                    selectedDays.remove(day)
                                                } else {
                                                    selectedDays.insert(day)
                                                }
                                            }
                                    }
                                }
                                Divider()

                                // Saat Seçimi
                                HStack {
                                    Text("Reminder Time")
                                    Spacer()
                                    DatePicker("", selection: $reminderTime, displayedComponents: .hourAndMinute)
                                        .labelsHidden()
                                }
                                
                                HStack {
                                    Text("Choose a Reminders sound")
                                        .font(.subheadline)
                                    Divider()
                                    Spacer()
                                    Text("🎵")
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.gray)
                                }
                            }
                            .padding()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding(.horizontal)


                            // Reminders Section
                            VStack(alignment: .leading, spacing: 16) {

                                Toggle("Show monthly report", isOn: $rapor)
                                    .toggleStyle(SwitchToggleStyle(tint: color))
                                Divider()

                                HStack {
                                    Text("Tap here to view premium advantages.")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.gray)
                                }
                                
                                Divider()
                                
                                HStack {
                                    Text("Upgrade to Premium")
                                    Spacer()
                                    Text("👑")
                                        .foregroundStyle(.yellow)
                                }
                            }
                            .padding()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding(.horizontal)

                            Spacer()
                        }
                        .opacity(animate ? 1 : 0)
                        .offset(y: animate ? 0 : 20)
                        .animation(.easeInOut(duration: 0.6), value: animate)
                        .onAppear {
                            animate = true
                        }
                    }
                }
            }
            .sheet(isPresented: $showingColorSheet) {
                VStack {
                    // Color Picker Header
                    HStack {
                        Text("Pick a Color")
                            .font(.title2)
                            .bold()
                            .padding(.top)
                        Spacer()
                        Button(action: { showingColorSheet = false }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .font(.title)
                        }
                    }
                    .padding()

                    // Grid of Colors
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 10) {
                        ForEach(colors, id: \.self) { col in
                            RoundedRectangle(cornerRadius: 12)
                                .fill(col)
                                .frame(height: 50)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.white, lineWidth: 4)
                                )
                                .onTapGesture {
                                    color = col
                                    showingColorSheet = false
                                }
                        }
                    }
                    .padding()
                }
                .presentationDetents([.medium])
            }
        }
    }
}

// Color Extension to handle hex
extension Color {
    init(hex: String) {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hexString)
        var hexValue: UInt64 = 0
        scanner.scanHexInt64(&hexValue)
        
        let red = Double((hexValue & 0xFF0000) >> 16) / 255.0
        let green = Double((hexValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(hexValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

struct AddCustomHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddCustomHabitView(color: .green)
    }
}
