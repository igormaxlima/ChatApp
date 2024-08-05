//
//  Message.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 16/07/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Message: Identifiable, Hashable, Codable {
    @DocumentID var messageId: String?
    let fromId: String
    let toId: String
    let messageText: String
    let timestamp: Timestamp
    var isRead: Bool
    
    var user: User?
    
    var id: String {
        return messageId ?? NSUUID().uuidString
    }
    
    var chatPartnerId: String {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
    
    var isFromCurrentUser: Bool {
        return fromId == Auth.auth().currentUser?.uid
    }
    
    var timestampString: String {
        return timestamp.dateValue().timestampString()
    }
}

extension Message {
    static let MESSAGE_MOCK = Message(
        messageId: "mockMessageId",
        fromId: "mockFromId",
        toId: "mockToId",
        messageText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vehicula felis ut enim efficitur, at tincidunt orci luctus.",
        timestamp: Timestamp(),
        isRead: false,
        user: User.MOCK_USER
    )
}
