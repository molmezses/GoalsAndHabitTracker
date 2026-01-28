//
//  ProgressView.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 22.04.2025.
//

import SwiftUI

struct ProgressView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var habit: Habit
    var updateHabit: (Habit) -> Void
    
    @FocusState private var isNoteEditorFocused: Bool
    @StateObject var viewModel = ProgressViewModel()
    
    
    var body: some View {
        ZStack {
            // Background tap area for dismissing keyboard
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    // Klavyeyi kapat
                    isNoteEditorFocused = false
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            
            VStack(spacing: 0) {
                
                // Header
                ProgressViewHeader
                
                // Scrollable Content
                ScrollView {
                    VStack(spacing: 0) {
                        // Progress View (Style'a göre değişir)
                        ProgressDisplayView
                        
                        // Habit Value Buttons
                        HabitValueButtons
                        
                        // Daily Notes Section
                        DailyNotesSection
                        
                        // Chart And Habit Setting Buttons
                        ChartAndHabitSettingButtons
                        
                        // Bottom padding for keyboard
                        Spacer()
                            .frame(height: 20)
                    }
                }
            }
            
            // Delete  habit Popup button
            if viewModel.showPopupMenu {
                HabitActionPopup(
                    onDelete: {
                        viewModel.deleteHabit(habit: habit) { success in
                            if success {
                                // Kısa bir gecikme ile dismiss çağır (Firestore güncellemesinin tamamlanması için)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    dismiss()
                                }
                            }
                        }
                    },
                    onDismiss: {
                        viewModel.showPopupMenu = false
                    }
                )
            }
            
            // Celebration Overlay
            if viewModel.showCelebration {
                CelebrationOverlay(
                    message: viewModel.celebrationMessage,
                    emoji: habit.emoji,
                    color: habit.color,
                    onDismiss: {
                        viewModel.showCelebration = false
                    }
                )
            }
        }
    }
    
    var ProgressViewHeader: some View{
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.secondary)
                    .padding(8)
                    .clipShape(Circle())
            }
            
            Spacer()
            
            Text(habit.title)
                .font(.headline)
                .fontWeight(.bold)
                .lineLimit(1)
            
            Spacer()
            
            HStack(spacing: 12) {
                Button {
                    viewModel.showStylePicker.toggle()
                } label: {
                    Image(systemName: "paintbrush.fill")
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .padding(8)
                        .clipShape(Circle())
                }
                
                Button {
                    viewModel.showPopupMenu.toggle()
                } label: {
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90))
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .padding(8)
                        .clipShape(Circle())
                }
            }
        }
        .padding()
        .background(Color(.systemBackground)
            .ignoresSafeArea(edges: .top))
    }
    
    var ProgressDisplayView: some View {
        Group {
            switch viewModel.progressStyle {
            case .circular:
                CircularProgressView
            case .linearBar:
                LinearBarProgressView
            case .halfCircle:
                HalfCircleProgressView
            case .wave:
                WaveProgressView
            }
        }
        .sheet(isPresented: $viewModel.showStylePicker) {
            StylePickerSheet
        }
    }
    
    // 1. Circular Progress (Mevcut)
    var CircularProgressView: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 12)
            
            Circle()
                .trim(from: 0, to: habit.progressPercentage)
                .stroke(habit.color ,style: StrokeStyle(lineWidth: 24, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: habit.progressPercentage)
            
            progressContent
        }
        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.5)
        .padding(.top)
        .opacity(viewModel.animate ? 1 : 0)
        .offset(y: viewModel.animate ? 0 : 20)
        .animation(.easeInOut(duration: 0.6), value: viewModel.animate)
        .onAppear {
            viewModel.animate = true
        }
    }
    
    // 2. Linear Bar Progress
    var LinearBarProgressView: some View {
        VStack(spacing: 24) {
            progressContent
            
            VStack(spacing: 12) {
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 40)
                        
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(
                                    colors: [habit.color, habit.color.opacity(0.7)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: geometry.size.width * habit.progressPercentage, height: 40)
                            .animation(.easeInOut, value: habit.progressPercentage)
                    }
                }
                .frame(height: 40)
                .padding(.horizontal, 40)
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.5)
        .padding(.top)
        .opacity(viewModel.animate ? 1 : 0)
        .offset(y: viewModel.animate ? 0 : 20)
        .animation(.easeInOut(duration: 0.6), value: viewModel.animate)
        .onAppear {
            viewModel.animate = true
        }
    }
    
    // 3. Half Circle Progress
    var HalfCircleProgressView: some View {
        ZStack(alignment: .center) {
            // Background half circle
            Circle()
                .trim(from: 0, to: 0.5)
                .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                .rotationEffect(.degrees(180))
            
            // Progress half circle
            Circle()
                .trim(from: 0, to: habit.progressPercentage * 0.5)
                .stroke(habit.color, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .rotationEffect(.degrees(180))
                .animation(.easeInOut, value: habit.progressPercentage)
            
            // Emoji and content positioned at the center-top of the half circle
            VStack(spacing: 8) {
                Text(habit.emoji)
                    .font(.system(size: 60))
                
                if habit.countingMode == .timer {
                    Text(habit.displayValue)
                        .font(.system(size: 36, weight: .bold))
                    if habit.timerTarget > 0 {
                        HStack(spacing:0){
                            Text("/")
                            Text(formatTime(habit.timerTarget))
                        }
                        .foregroundStyle(.gray)
                        .font(.title3)
                    }
                } else {
                    HStack {
                        Text("\(Int(habit.countingMode == .backward ? max(0, habit.current) : habit.current))")
                        Text(habit.countingMode == .timer ? "" : "Times")
                    }
                    .font(.title2)
                    HStack(spacing:0){
                        Text("/")
                        Text("\(Int(habit.total))")
                    }
                    .foregroundStyle(.gray)
                }
            }
            .offset(y: -UIScreen.main.bounds.width * 0.15)
        }
        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.5)
        .padding(.top)
        .opacity(viewModel.animate ? 1 : 0)
        .offset(y: viewModel.animate ? 0 : 20)
        .animation(.easeInOut(duration: 0.6), value: viewModel.animate)
        .onAppear {
            viewModel.animate = true
        }
    }
    
    // 4. Wave Progress
    var WaveProgressView: some View {
        ZStack {
            // Background circle
            Circle()
                .fill(Color.gray.opacity(0.1))
                .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.width * 0.7)
            
            // Wave effect - clipped to circle
            WaveShape(progress: habit.progressPercentage)
                .fill(
                    LinearGradient(
                        colors: [habit.color, habit.color.opacity(0.7)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.width * 0.7)
                .clipShape(Circle())
                .animation(.easeInOut(duration: 1.0), value: habit.progressPercentage)
            
            progressContent
        }
        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.5)
        .padding(.top)
        .opacity(viewModel.animate ? 1 : 0)
        .offset(y: viewModel.animate ? 0 : 20)
        .animation(.easeInOut(duration: 0.6), value: viewModel.animate)
        .onAppear {
            viewModel.animate = true
        }
    }
    
    // Ortak içerik (emoji ve değerler)
    var progressContent: some View {
        VStack(spacing: 8) {
            Text(habit.emoji)
                .font(.system(size: 48))
            
            if habit.countingMode == .timer {
                Text(habit.displayValue)
                    .font(.system(size: 36, weight: .bold))
                if habit.timerTarget > 0 {
                    HStack(spacing:0){
                        Text("/")
                        Text(formatTime(habit.timerTarget))
                    }
                    .foregroundStyle(.gray)
                    .font(.title3)
                }
            } else {
                HStack {
                    Text("\(Int(habit.countingMode == .backward ? max(0, habit.current) : habit.current))")
                    Text(habit.countingMode == .timer ? "" : "Times")
                }
                .font(.title2)
                HStack(spacing:0){
                    Text("/")
                    Text("\(Int(habit.total))")
                }
                .foregroundStyle(.gray)
            }
        }
    }
    
    // Style Picker Sheet
    var StylePickerSheet: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Select Progress Style")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top)
                
                VStack(spacing: 16) {
                    ForEach(ProgressStyle.allCases, id: \.self) { style in
                        Button {
                            viewModel.progressStyle = style
                            viewModel.showStylePicker = false
                        } label: {
                            HStack(spacing: 16) {
                                Image(systemName: style.icon)
                                    .font(.title2)
                                    .foregroundColor(viewModel.progressStyle == style ? habit.color : .gray)
                                    .frame(width: 40)
                                
                                Text(style.name)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                if viewModel.progressStyle == style {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(habit.color)
                                        .font(.title3)
                                }
                            }
                            .padding()
                            .background(viewModel.progressStyle == style ? habit.color.opacity(0.1) : Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(viewModel.progressStyle == style ? habit.color : Color.clear, lineWidth: 2)
                            )
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        viewModel.showStylePicker = false
                    }
                    .foregroundColor(habit.color)
                }
            }
        }
    }
    
    private func formatTime(_ seconds: Double) -> String {
        let hours = Int(seconds) / 3600
        let minutes = (Int(seconds) % 3600) / 60
        let secs = Int(seconds) % 60
        
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, secs)
        } else {
            return String(format: "%d:%02d", minutes, secs)
        }
    }
    
    var HabitValueButtons: some View{
        VStack(spacing: 12) {
            if habit.countingMode == .timer {
                // Timer Controls
                TimerControlsView(habit: $habit, updateHabit: updateHabit, viewModel: viewModel)
            } else {
                // Custom Value Input
                if viewModel.showValueInput {
                    CustomValueInputView
                }
                
                // Standard Counter Controls
                HStack(spacing: 12) {
                    Button {
                        let date = viewModel.formattedTodayDate()
                        
                        if habit.countingMode == .forward {
                            // Forward: azalt
                            habit.current = max(habit.current - (habit.total / 10), 0)
                        } else {
                            // Backward: current'i artır (geri sayımı geri al, 0'dan uzaklaş)
                            habit.current = min(habit.current + (habit.total / 10), habit.total)
                        }
                        
                        // Tamamlanma durumunu kontrol et ve güncelle
                        if !habit.isCompletedByMode {
                            viewModel.removeTodayIfCompleted(habit: &habit)
                        } else {
                            if !habit.complatedDay.contains(date) {
                                habit.complatedDay.append(date)
                            }
                        }
                        
                        habit.lastUpdated = Date()
                        habit.missing = viewModel.calcMissingDay(habit: habit)
                        viewModel.updateLongestSeries(habit: &habit)
                        updateHabit(habit)
                    } label: {
                        Image(systemName: "minus")
                            .foregroundStyle(.black)
                            .padding()
                            .font(.headline)
                            .background(Color(.systemGroupedBackground))
                            .clipShape(Circle())
                    }
                    
                    Button {
                        let date = viewModel.formattedTodayDate()
                        let wasAlreadyCompleted = habit.complatedDay.contains(date)
                        
                        if habit.countingMode == .forward {
                            habit.current = habit.total
                        } else {
                            habit.current = 0
                        }
                        
                        // Tamamlanma durumunu kontrol et ve güncelle
                        if habit.isCompletedByMode {
                            if !habit.complatedDay.contains(date) {
                                habit.complatedDay.append(date)
                            }
                        } else {
                            viewModel.removeTodayIfCompleted(habit: &habit)
                        }
                        
                        habit.lastUpdated = Date()
                        habit.missing = viewModel.calcMissingDay(habit: habit)
                        viewModel.updateLongestSeries(habit: &habit)
                        updateHabit(habit)
                        
                        // Celebration tetikle
                        if habit.isCompletedByMode && !wasAlreadyCompleted {
                            viewModel.triggerCelebration(habit: habit)
                        }
                    } label: {
                        Image(systemName: "checkmark")
                            .imageScale(.large)
                            .bold()
                            .padding()
                            .foregroundStyle(.white)
                            .background(habit.color)
                            .mask(Circle())
                    }
                    
                    Button {
                        let date = viewModel.formattedTodayDate()
                        let wasAlreadyCompleted = habit.complatedDay.contains(date)
                        
                        if habit.countingMode == .forward {
                            // Forward: artır
                            habit.current = min(habit.current + (habit.total / 10), habit.total)
                        } else {
                            // Backward: current'i azalt (geri sayım, 0'a yaklaş)
                            habit.current = max(habit.current - (habit.total / 10), 0)
                        }
                        
                        // Tamamlanma durumunu kontrol et ve güncelle
                        if habit.isCompletedByMode {
                            if !habit.complatedDay.contains(date) {
                                habit.complatedDay.append(date)
                            }
                        } else {
                            viewModel.removeTodayIfCompleted(habit: &habit)
                        }
                        
                        habit.lastUpdated = Date()
                        habit.missing = viewModel.calcMissingDay(habit: habit)
                        viewModel.updateLongestSeries(habit: &habit)
                        updateHabit(habit)
                        
                        // Celebration tetikle
                        if habit.isCompletedByMode && !wasAlreadyCompleted {
                            viewModel.triggerCelebration(habit: habit)
                        }
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.black)
                            .padding(6)
                            .font(.headline)
                            .background(Color(.systemGroupedBackground))
                            .clipShape(Circle())
                    }
                    .padding(.leading , 6)
                    .disabled(viewModel.disableButton(habit: habit))
                    .opacity(viewModel.disableButton(habit: habit) ? 0 : 1)
                    
                    // Custom Value Input Button
                    Button {
                        viewModel.showValueInput.toggle()
                        if !viewModel.showValueInput {
                            viewModel.customValueText = ""
                        } else {
                            viewModel.customValueText = "\(Int(habit.current))"
                        }
                    } label: {
                        Image(systemName: viewModel.showValueInput ? "xmark" : "keyboard")
                            .foregroundStyle(.black)
                            .padding(6)
                            .font(.headline)
                            .background(Color(.systemGroupedBackground))
                            .clipShape(Circle())
                    }
                }
            }
        }
        .padding(.bottom)
        .opacity(viewModel.animate ? 1 : 0)
        .offset(y: viewModel.animate ? 0 : 20)
        .animation(.easeInOut(duration: 0.6), value: viewModel.animate)
    }
    
    var CustomValueInputView: some View {
        HStack(spacing: 12) {
            TextField("Enter value", text: $viewModel.customValueText)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .frame(width: 120)
            
            Button {
                applyCustomValue()
            } label: {
                Text("Apply")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(habit.color)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
    
    private func applyCustomValue() {
        guard let value = Double(viewModel.customValueText) else { return }
        
        let date = viewModel.formattedTodayDate()
        let wasAlreadyCompleted = habit.complatedDay.contains(date)
        
        // Değeri 0 ile total arasında sınırla
        let clampedValue: Double
        if habit.countingMode == .forward {
            clampedValue = max(0, min(value, habit.total))
        } else {
            // Backward modunda: 0 ile total arasında
            clampedValue = max(0, min(value, habit.total))
        }
        
        habit.current = clampedValue
        
        // Tamamlanma durumunu kontrol et ve güncelle
        if habit.isCompletedByMode {
            if !habit.complatedDay.contains(date) {
                habit.complatedDay.append(date)
            }
        } else {
            viewModel.removeTodayIfCompleted(habit: &habit)
        }
        
        habit.lastUpdated = Date()
        habit.missing = viewModel.calcMissingDay(habit: habit)
        viewModel.updateLongestSeries(habit: &habit)
        updateHabit(habit)
        viewModel.showValueInput = false
        viewModel.customValueText = ""
        
        // Celebration tetikle
        if habit.isCompletedByMode && !wasAlreadyCompleted {
            viewModel.triggerCelebration(habit: habit)
        }
    }
    
    var DailyNotesSection: some View {
        VStack(spacing: 12) {
            // Today's Note Card
            if !viewModel.showNoteEditor {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "note.text")
                            .foregroundColor(habit.color)
                            .font(.title3)
                        
                        Text("Today's Note")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Button {
                            let todayNote = viewModel.getTodayNote(for: habit)
                            viewModel.noteText = todayNote
                            viewModel.showNoteEditor = true
                        } label: {
                            Image(systemName: viewModel.getTodayNote(for: habit).isEmpty ? "plus.circle.fill" : "pencil.circle.fill")
                                .foregroundColor(habit.color)
                                .font(.title3)
                        }
                    }
                    
                    let todayNote = viewModel.getTodayNote(for: habit)
                    if !todayNote.isEmpty {
                        Text(todayNote)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.top, 4)
                    } else {
                        VStack(spacing: 8) {
                            Text(viewModel.getRandomMotivationalMessage())
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .italic()
                                .multilineTextAlignment(.center)
                            
                            Text("Tap + to add your own note")
                                .font(.caption)
                                .foregroundColor(.secondary.opacity(0.7))
                        }
                        .padding(.vertical, 8)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.secondarySystemBackground))
                        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                )
                .padding(.horizontal)
            } else {
                // Note Editor
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "note.text")
                            .foregroundColor(habit.color)
                            .font(.title3)
                        
                        Text("Today's Note")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Button {
                            viewModel.showNoteEditor = false
                            viewModel.noteText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.secondary)
                                .font(.title3)
                        }
                    }
                    
                    TextEditor(text: $viewModel.noteText)
                        .focused($isNoteEditorFocused)
                        .frame(minHeight: 100)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(habit.color.opacity(0.3), lineWidth: 1)
                        )
                        .onAppear {
                            // Klavyeyi otomatik aç
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                isNoteEditorFocused = true
                            }
                        }
                    
                    HStack {
                        Button {
                            viewModel.showNoteEditor = false
                            viewModel.noteText = ""
                        } label: {
                            Text("Cancel")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                                .background(Color(.systemGray6))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        
                        Spacer()
                        
                        Button {
                            viewModel.saveNote(for: &habit, note: viewModel.noteText)
                            habit.lastUpdated = Date()
                            updateHabit(habit)
                            viewModel.showNoteEditor = false
                        } label: {
                            Text("Save")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                                .background(habit.color)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.secondarySystemBackground))
                        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                )
                .padding(.horizontal)
            }
        }
        .padding(.vertical, 8)
        .opacity(viewModel.animate ? 1 : 0)
        .offset(y: viewModel.animate ? 0 : 20)
        .animation(.easeInOut(duration: 0.6), value: viewModel.animate)
    }
    
    var ChartAndHabitSettingButtons: some View {
        HStack {
            Button {
                viewModel.showSheet.toggle()
            } label: {
                Image(systemName: "chart.bar.fill")
                    .foregroundStyle(.black)
                    .padding()
                    .font(.headline)
                    .fontDesign(.rounded)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Circle())
            }
            NavigationLink {
                UpdateView(habit: habit)
                    .navigationBarBackButtonHidden()
            } label: {
                Image(systemName: "gear")
                    .foregroundStyle(.black)
                    .padding()
                    .font(.headline)
                    .fontDesign(.rounded)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Circle())
            }
            .foregroundStyle(.black)
        }
        .fullScreenCover(isPresented: $viewModel.showSheet) {
            StatusViewRedesigned(habit: habit)
                .environmentObject(StatusViewModel())
        }
        .opacity(viewModel.animate ? 1 : 0)
        .offset(y: viewModel.animate ? 0 : 20)
        .animation(.easeInOut(duration: 0.6), value: viewModel.animate)
    }
}

// MARK: - Celebration Overlay
struct CelebrationOverlay: View {
    let message: String
    let emoji: String
    let color: Color
    let onDismiss: () -> Void
    
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0
    @State private var rotation: Double = 0
    @State private var confettiParticles: [ConfettiParticle] = []
    
    struct ConfettiParticle: Identifiable {
        let id = UUID()
        var x: CGFloat
        var y: CGFloat
        var color: Color
        var rotation: Double
        var speed: CGFloat
    }
    
    var body: some View {
        ZStack {
            // Arka plan blur
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss()
                }
            
            // Konfeti parçacıkları
            ForEach(confettiParticles) { particle in
                RoundedRectangle(cornerRadius: 4)
                    .fill(particle.color)
                    .frame(width: 12, height: 12)
                    .rotationEffect(.degrees(particle.rotation))
                    .offset(x: particle.x, y: particle.y)
            }
            
            // Başarı mesajı
            VStack(spacing: 20) {
                Text(emoji)
                    .font(.system(size: 100))
                    .scaleEffect(scale)
                    .rotationEffect(.degrees(rotation))
                
                Text(message)
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(color)
                    .opacity(opacity)
                
                Text("Hedefine ulaştın! 🎯")
                    .font(.title2)
                    .foregroundColor(.secondary)
                    .opacity(opacity)
            }
            .padding(50)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(.ultraThinMaterial)
                    .shadow(color: color.opacity(0.3), radius: 30, x: 0, y: 10)
            )
            .scaleEffect(scale)
            .opacity(opacity)
        }
        .onAppear {
            // Konfeti parçacıklarını oluştur
            confettiParticles = (0..<50).map { _ in
                ConfettiParticle(
                    x: CGFloat.random(in: -200...200),
                    y: -100,
                    color: [color, .yellow, .orange, .pink, .purple, .blue, .green].randomElement() ?? color,
                    rotation: Double.random(in: 0...360),
                    speed: CGFloat.random(in: 2...5)
                )
            }
            
            // Ana animasyon
            withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                scale = 1.0
                opacity = 1.0
            }
            
            // Emoji rotasyon animasyonu
            withAnimation(.easeInOut(duration: 0.5).repeatCount(3, autoreverses: true)) {
                rotation = 15
            }
            
            // Konfeti animasyonu
            for i in confettiParticles.indices {
                withAnimation(.easeOut(duration: Double.random(in: 1.5...3.0)).delay(Double.random(in: 0...0.5))) {
                    confettiParticles[i].y = 1000
                    confettiParticles[i].x += CGFloat.random(in: -100...100)
                    confettiParticles[i].rotation += Double.random(in: 180...720)
                }
            }
        }
    }
}


