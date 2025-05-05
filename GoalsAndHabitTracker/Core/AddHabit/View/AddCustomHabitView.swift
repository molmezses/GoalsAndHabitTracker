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
    @EnvironmentObject var soundVM: SoundViewModel

    @State var goToHome: Bool = false


    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                headerView
                contentView
            }
            .sheet(isPresented: $viewModel.showingColorSheet) {
                colorPickerSheet
            }
            .navigationDestination(isPresented: $goToHome) {
                HomeView()
                    .navigationBarBackButtonHidden()
                    .environmentObject(AddCustomHabitViewModel())
                    .environmentObject(HabitBarSettingsViewModel())
                    .environmentObject(StatusViewModel())
                    .environmentObject(ProgressViewModel())
                    .environmentObject(UpdateViewModel())
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
            Text("Add habit")
                .font(.headline)
                .fontWeight(.bold)

            Spacer()

            Button(action: {
                viewModel.createHabit(soundVM: soundVM)
                goToHome = true
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
                Text("/\(viewModel.selectedUnit)")
                    .font(.subheadline)
            }

            Divider()

            settingsRow(title: "Select a category") {
                Menu {
                    Button("Piece") { viewModel.selectedUnit = "Piece" }
                        Button("Page") { viewModel.selectedUnit = "Page" }
                        Button("Day") { viewModel.selectedUnit = "Day" }
                        Button("Calorie") { viewModel.selectedUnit = "Calorie" }
                        Button("Liter") { viewModel.selectedUnit = "Liter" }
                        Button("ml") { viewModel.selectedUnit = "ml" }
                        Button("km") { viewModel.selectedUnit = "km" }
                        Button("Step") { viewModel.selectedUnit = "Step" }
                        Button("Hour") { viewModel.selectedUnit = "Hour" }
                        Button("Minute") { viewModel.selectedUnit = "Minute" }
                        Button("Episode") { viewModel.selectedUnit = "Episode" }
                        Button("Word") { viewModel.selectedUnit = "Word" }
                        Button("Sentence") { viewModel.selectedUnit = "Sentence" }
                        Button("Article") { viewModel.selectedUnit = "Article" }
                        Button("Lesson") { viewModel.selectedUnit = "Lesson" }
                        Button("Question") { viewModel.selectedUnit = "Question" }
                        Button("Repeat") { viewModel.selectedUnit = "Repeat" }
                        Button("Exercise") { viewModel.selectedUnit = "Exercise" }
                        Button("Breath") { viewModel.selectedUnit = "Breath" }
                        Button("Distance") { viewModel.selectedUnit = "Distance" }
                        Button("Time") { viewModel.selectedUnit = "Time" }
                        Button("Task") { viewModel.selectedUnit = "Task" }
                        Button("Practice") { viewModel.selectedUnit = "Practice" }
                        Button("Journal") { viewModel.selectedUnit = "Journal" }
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
            
            VStack {
                HStack {
                    Text("Reminder Message")
                    Spacer()
                }
                Spacer()
                TextField("Enter a message", text: $viewModel.reminderMessage)
                
            }
            

            Divider()

            HStack {
                Text("Reminder Time")
                Spacer()
                DatePicker("", selection: $viewModel.reminderTime, displayedComponents: .hourAndMinute)
                    .labelsHidden()
            }

            Divider()

            NavigationLink {
                SelectSoundView()
                    .environmentObject(soundVM) // BURASI ÖNEMLİ
                    .navigationBarBackButtonHidden()
            } label: {
                settingsRow(title: "Choose a Reminder sound") {
                    Text("\(soundVM.selectedSound)")
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
                .foregroundStyle(.black)
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
        "📔", "🌱", "🍇", "🍊", "🍉", "🧂", "🍞", "🧀", "🥗",
        "🥛", "☕️", "🍵", "🧊", "🍽️", "🧁", "🍫", "🍯", "🍔", "🌮",
        "🌯", "🛒", "🧼", "🧽", "🚿", "🛁", "🧖‍♀️", "🧖‍♂️", "🪥", "🪒",
        "💻", "🖥️", "📱", "📞", "🎧", "🎼", "🕹️", "📺", "🗓️", "📌",
        "📎", "📇", "🗂️", "🗃️", "📁", "🗄️", "📤", "📥", "🧾",
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




struct AddCustomHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddCustomHabitView()
            .environmentObject(AddCustomHabitViewModel())
            .environmentObject(SoundViewModel())
    }
}
