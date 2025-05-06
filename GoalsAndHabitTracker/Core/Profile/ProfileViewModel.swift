//
//  ProfileViewModel.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 6.05.2025.
//

import Foundation

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var profileImage: UIImage?
    
    private let imageFileName = "profile.jpg"
    
    init() {
        loadProfileImage()
    }

    func saveProfileImage(_ image: UIImage) {
        if let data = image.jpegData(compressionQuality: 0.8) {
            let url = getDocumentsDirectory().appendingPathComponent(imageFileName)
            try? data.write(to: url)
            profileImage = image
        }
    }

    func loadProfileImage() {
        let url = getDocumentsDirectory().appendingPathComponent(imageFileName)
        if let data = try? Data(contentsOf: url),
           let image = UIImage(data: data) {
            profileImage = image
        }
    }

    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
