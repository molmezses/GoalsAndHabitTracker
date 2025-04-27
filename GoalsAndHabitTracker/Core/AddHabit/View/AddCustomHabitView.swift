//
//  AddCustomHabitView.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 22.04.2025.
//
import SwiftUI

struct AddCustomHabitView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AddCustomHabitViewModel


    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                headerView
                contentView
            }
            .sheet(isPresented: $viewModel.showingColorSheet) {
                colorPickerSheet
            }
        }
    }

    private var headerView: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding(8)
            }

            Text(viewModel.selectedEmoji)
            Text("Add a custom habit")
                .font(.headline)
                .fontWeight(.bold)

            Spacer()

            Button(action: {
                viewModel.createHabit()
            }) {
                Text("Save")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .padding(6)
                    .background(viewModel.color)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding()
        .background(viewModel.color.opacity(0.2))
    }

    private var contentView: some View {
        ZStack {
            viewModel.color.opacity(0.2).ignoresSafeArea()

            ScrollView {
                VStack(spacing: 16) {
                    habitDetailsSection
                    reminderSettingsSection
                    premiumSection

                    Spacer()
                }
                .opacity(viewModel.animate ? 1 : 0)
                .offset(y: viewModel.animate ? 0 : 20)
                .animation(.easeInOut(duration: 0.6), value: viewModel.animate)
                .onAppear { viewModel.animate = true }
            }
        }
    }

    private var habitDetailsSection: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                Text(viewModel.selectedEmoji)
                    .font(.title)
                    .padding(12)
                    .background(viewModel.color.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                TextField("Habit name", text: $viewModel.title)
                    .font(.headline)

                Spacer()
            }

            Divider()

            settingsRow(title: "Color") {
                Button(action: { viewModel.showingColorSheet.toggle() }) {
                    HStack {
                        RoundedRectangle(cornerRadius: 24)
                            .frame(width: 36, height: 16)
                            .foregroundStyle(viewModel.color)
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.gray)
                    }
                }
            }

            Divider()

            settingsRow(title: "Emoji") {
                Button(action: { viewModel.showingEmojiSheet.toggle() }) {
                    Text(viewModel.selectedEmoji)
                        .font(.title2)
                }
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
            .sheet(isPresented: $viewModel.showingEmojiSheet) {
                EmojiPickerView(selectedEmoji: $viewModel.selectedEmoji)
            }

            Divider()

            settingsRow(title: "Target Value") {
                TextField("100", text: $viewModel.targetAmount)
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

            settingsRow(title: "Select a category") {
                Menu {
                    Button("Adet") { viewModel.selectedUnit = "Adet" }
                    Button("Sayfa") { viewModel.selectedUnit = "Sayfa" }
                    Button("Gün") { viewModel.selectedUnit = "Gün" }
                    Button("Kalori") { viewModel.selectedUnit = "Kalori" }
                    Button("Litre") { viewModel.selectedUnit = "Litre" }
                } label: {
                    HStack {
                        Text(viewModel.selectedUnit)
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

            settingsRow(title: "Task Days") {
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
    }

    private var reminderSettingsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Toggle("Reminders", isOn: $viewModel.reminderIsOn)
                .toggleStyle(SwitchToggleStyle(tint: viewModel.color))

            Divider()

            HStack(spacing: 10) {
                ForEach(viewModel.weekdays, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .frame(width: 36, height: 36)
                        .background(viewModel.selectedDays.contains(day) ? viewModel.color : viewModel.color.opacity(0.4))
                        .foregroundColor(viewModel.selectedDays.contains(day) ? .white : .black)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .onTapGesture {
                            if viewModel.selectedDays.contains(day) {
                                viewModel.selectedDays.remove(day)
                            } else {
                                viewModel.selectedDays.insert(day)
                            }
                        }
                }
            }

            Divider()

            HStack {
                Text("Reminder Time")
                Spacer()
                DatePicker("", selection: $viewModel.reminderTime, displayedComponents: .hourAndMinute)
                    .labelsHidden()
            }

            Divider()

            settingsRow(title: "Choose a Reminder sound") {
                Text("🎵")
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }

    private var premiumSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Toggle("Show monthly report", isOn: $viewModel.rapor)
                .toggleStyle(SwitchToggleStyle(tint: viewModel.color))

            Divider()

            settingsRow(title: "Tap here to view premium advantages.") {
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }

            Divider()

            settingsRow(title: "Upgrade to Premium") {
                Text("👑")
                    .foregroundStyle(.yellow)
            }
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }

    private var colorPickerSheet: some View {
        VStack {
            HStack {
                Text("Pick a Color")
                    .font(.title2)
                    .bold()
                Spacer()
                Button(action: { viewModel.showingColorSheet = false }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .font(.title2)
                }
            }
            .padding()

            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 44))], spacing: 16) {
                    ForEach(viewModel.colors, id: \.self) { col in
                        Circle()
                            .fill(col)
                            .frame(width: 44, height: 44)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: viewModel.color == col ? 3 : 0)
                            )
                            .shadow(radius: viewModel.color == col ? 4 : 0)
                            .onTapGesture {
                                viewModel.color = col
                                viewModel.showingColorSheet = false
                            }
                    }
                }
                .padding()
            }
        }
        .presentationDetents([.medium, .large])
    }

    // Helper to build settings rows
    private func settingsRow<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        HStack {
            Text(title)
                .font(.subheadline)
            Spacer()
            content()
        }
    }
}




struct EmojiPickerView: View {
    @Binding var selectedEmoji: String
    @Environment(\.dismiss) var dismiss

    let emojis = [
        "🔥", "💪", "📚", "🏃‍♂️", "🧘", "📝", "🎯", "🥦", "💧", "🛏️",
        "🎵", "👑", "🚭", "⏰", "🧹", "📖", "🎨", "👟", "💼", "🧠",
        "❤️", "😎", "🌟", "🍎", "☀️", "🌙", "📅", "🥇", "🍀", "💡",
        "🧪", "🧴", "💤", "📷", "🎮", "🧺", "🚶", "💬", "📈", "📦",
        "📔", "📦", "🌱", "🍇", "🍊", "🍉", "🧂", "🍞", "🧀", "🥗",
        "🥛", "☕️", "🍵", "🧊", "🍽️", "🧁", "🍫", "🍯", "🍔", "🌮",
        "🌯", "🛒", "🧼", "🧽", "🚿", "🛁", "🧖‍♀️", "🧖‍♂️", "🪥", "🪒",
        "💻", "🖥️", "📱", "📞", "🎧", "🎼", "🕹️", "📺", "🗓️", "📌",
        "📎", "📝", "📇", "🗂️", "🗃️", "📁", "🗄️", "📤", "📥", "🧾",
        "💳", "💰", "📊", "🪙", "💎", "🛠️", "🧰", "🧱", "🧲", "🧭"
    ]

    let columns = [GridItem(.adaptive(minimum: 60))]

    var body: some View {
        VStack {
            HStack {
                Text("Choose Emoji")
                    .font(.title2)
                    .bold()
                Spacer()
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .font(.title2)
                }
            }
            .padding()

            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(emojis, id: \.self) { emoji in
                        Text(emoji)
                            .font(.largeTitle)
                            .frame(width: 60, height: 60)
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .onTapGesture {
                                selectedEmoji = emoji
                                dismiss()
                            }
                    }
                }
                .padding()
            }
        }
        .presentationDetents([.medium, .large])
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
        AddCustomHabitView()
            .environmentObject(AddCustomHabitViewModel())
            .environmentObject(HabitViewModel())
    }
}
