//
//  FeatureView.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 6.05.2025.
//
import SwiftUI
import Firebase

struct FeedbackView: View {
    @State private var feedbackText: String = ""
    @State private var isSubmitted: Bool = false
    @FocusState private var isTextEditorFocused: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header - Fixed
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
                    
                    Text("Feedback & Suggestions")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Spacer()
                }
                .padding()
                .background(Color.white.ignoresSafeArea(edges: .top))
                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 5)
                
                // Main Content
                ScrollView {
                    VStack(spacing: 24) {
                        if isSubmitted {
                            // Thank you message
                            VStack(spacing: 16) {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 60))
                                    .foregroundColor(.green)
                                
                                Text("Thank You!")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Text("We appreciate your feedback. We will review it as soon as possible.")
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal, 24)
                            }
                            .padding(.vertical, 40)
                            .transition(.scale.combined(with: .opacity))
                            .animation(.easeInOut, value: isSubmitted)
                        } else {
                            // Feedback form
                            VStack(alignment: .leading, spacing: 16) {
                                // Title
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Get in Touch")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                    
                                    Text("We are eager to hear your thoughts on how we can improve the app.")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                
                                // TextEditor
                                VStack {
                                    TextEditor(text: $feedbackText)
                                        .focused($isTextEditorFocused)
                                        .frame(minHeight: 200, maxHeight: 300)
                                        .padding(12)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color.white)
                                                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                                        )
                                        .overlay(
                                            feedbackText.isEmpty ?
                                            Text("Write your feedback and suggestions here...")
                                                .foregroundColor(.gray.opacity(0.5))
                                                .padding(20)
                                                .frame(maxWidth: .infinity, alignment: .topLeading)
                                                .allowsHitTesting(false)
                                            : nil
                                        )
                                }
                                
                                // Character counter
                                HStack {
                                    Spacer()
                                    Text("\(feedbackText.count)/500")
                                        .font(.caption)
                                        .foregroundColor(feedbackText.count > 500 ? .red : .secondary)
                                }
                                
                                // Submit button
                                Button(action: sendFeedback) {
                                    HStack {
                                        Spacer()
                                        Text("Submit")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Spacer()
                                    }
                                    .padding()
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .cornerRadius(12)
                                    .shadow(color: .blue.opacity(0.3), radius: 8, x: 0, y: 4)
                                    .opacity(feedbackText.isEmpty ? 0.6 : 1.0)
                                }
                                .disabled(feedbackText.isEmpty || feedbackText.count > 500)
                                .animation(.easeInOut, value: feedbackText.isEmpty)
                            }
                            .padding()
                        }
                    }
                    .padding(.top, 16)
                }
                .background(Color(.systemGroupedBackground))
                .onTapGesture {
                    isTextEditorFocused = false
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    func sendFeedback() {
        guard !feedbackText.isEmpty else { return }
        
        let feedbackId = UUID().uuidString
        let feedbackData: [String: Any] = [
            "message": feedbackText
        ]
        
        // Add data to Firestore
        let db = Firestore.firestore()
        db.collection("feedback").document(feedbackId).setData(feedbackData) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                // Feedback sent successfully
                print("Feedback sent")
                withAnimation {
                    isSubmitted = true
                    feedbackText = ""
                }
            }
        }
    }
}

#Preview {
    FeedbackView()
}
