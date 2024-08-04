//
//  InboxService.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 19/07/24.
//

import Foundation
import Firebase

class InboxService {
    @Published var documentChanges = [DocumentChange]()
    
    func observeRecentMessages() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = FirestoreConstants
            .MessagesCollecttion
            .document(uid)
            .collection("recent-messages")
            .order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({
                $0.type == .added || $0.type == .modified
            }) else { return }
            
            self.documentChanges = changes
        }
    }
    
    func deleteMessages(chatPartner: User) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let db = Firestore.firestore()
        let currentUserRef = FirestoreConstants.MessagesCollecttion.document(currentUid).collection(chatPartnerId)
        let recentCurrentUserRef = FirestoreConstants.MessagesCollecttion.document(currentUid).collection("recent-messages").document(chatPartnerId)
        
        let batch = db.batch()
        
        let currentUserSnapshot = try await currentUserRef.getDocuments()
        currentUserSnapshot.documents.forEach { batch.deleteDocument($0.reference) }
        
        batch.deleteDocument(recentCurrentUserRef)
        
        try await batch.commit()
    }
}
