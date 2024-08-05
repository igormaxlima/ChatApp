//
//  ChatService.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 18/07/24.
//

import Foundation
import Firebase

struct ChatService {
    
    let chatPartner: User
    
    func sendMessage(_ messageText: String) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let currentUserRef = FirestoreConstants.MessagesCollecttion.document(currentUid).collection(chatPartnerId).document()
        let chatPartnerRef = FirestoreConstants.MessagesCollecttion.document(chatPartnerId).collection(currentUid)
        
        let recentCurrentUserRef = FirestoreConstants.MessagesCollecttion.document(currentUid).collection("recent-messages").document(chatPartnerId)
        let recentPartnerRef = FirestoreConstants.MessagesCollecttion.document(chatPartnerId).collection("recent-messages").document(currentUid)
        
        let messageId = currentUserRef.documentID
        
        let message = Message(
            messageId: messageId,
            fromId: currentUid,
            toId: chatPartnerId,
            messageText: messageText,
            timestamp: Timestamp(),
            isRead: false
        )
        
        guard let messageData = try? Firestore.Encoder().encode(message) else { return }
        
        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageId).setData(messageData)
        
        recentCurrentUserRef.setData(messageData)
        recentPartnerRef.setData(messageData)
    }
    
    // real time effect
    func observeMessages(completion: @escaping([Message]) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let query = FirestoreConstants.MessagesCollecttion
            .document(currentUid)
            .collection(chatPartnerId)
            .order(by: "timestamp", descending: false)
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added || $0.type == .modified }) else { return }
            var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
            
            for (index, message) in messages.enumerated() where !message.isFromCurrentUser {
                messages[index].user = chatPartner
            }
            
            completion(messages)
        }
    }
    
    func markMessagesAsRead() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let chatPartnerMessagesRef = FirestoreConstants.MessagesCollecttion.document(chatPartnerId).collection(currentUid)
        let recentCurrentUserRef = FirestoreConstants.MessagesCollecttion.document(currentUid).collection("recent-messages").document(chatPartnerId)
        
        let snapshot = try await chatPartnerMessagesRef
            .whereField("isRead", isEqualTo: false)
            .getDocuments()
        
        let filteredDocuments = snapshot.documents.filter({ $0["fromId"] as? String != currentUid })
        
        guard !filteredDocuments.isEmpty else { return }
        
        let batch = Firestore.firestore().batch()
        
        filteredDocuments.forEach { batch.updateData(["isRead": true], forDocument: $0.reference) }
        batch.updateData(["isRead": true], forDocument: recentCurrentUserRef)
        
        try await batch.commit()
    }
}
