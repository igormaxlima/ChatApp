//
//  ProfileViewModel.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 15/03/24.
//

import Foundation
import SwiftUI
import PhotosUI
import FirebaseStorage
import Firebase

@Observable class ProfileViewModel {
    var selectedPhoto: PhotosPickerItem? {
        didSet { Task { try await loadImage() } }
    }
    
    var profileImage: Image?
    var imageService = ImageService.shared
    
    func loadImage() async throws {
        guard let item = selectedPhoto else { return }
        guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: imageData) else { return }
        self.profileImage = Image(uiImage: uiImage)
        imageService.uploadImage(uiImage)
    }
    
}



