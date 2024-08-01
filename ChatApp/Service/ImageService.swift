//
//  ImageService.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 31/07/24.
//

import Foundation
import SwiftUI
import FirebaseStorage
import Firebase

class ImageService {
    static let shared = ImageService()
    
    func uploadImage(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let imagesRef = StorageConstants.StorageReference.child("profilesPic/\(UUID().uuidString).jpg")
        
        let uploadTask = imagesRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Upload error: \(error.localizedDescription)")
                return
            }
            
            imagesRef.downloadURL { url, error in
                if let error = error {
                    print("Error getting download URL: \(error.localizedDescription)")
                    return
                }
                
                guard let downloadURL = url else { return }
                print("Download URL: \(downloadURL.absoluteString)")
                self.updateProfileImageUrlToDatabase(downloadURL.absoluteString)
                self.loadCurrentUserData()
            }
        }
    }
    
    private func updateProfileImageUrlToDatabase(_ url: String) {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        
        FirestoreConstants.UserCollection.document(currentUserUid).updateData(["profileImageUrl": url]) { error in
            if let error = error {
                print("Error updating profile image URL: \(error.localizedDescription)")
                return
            }
        }
    }
    
    private func loadCurrentUserData() {
        Task { try await UserService.shared.fetchCurrentUser() }
    }
}
