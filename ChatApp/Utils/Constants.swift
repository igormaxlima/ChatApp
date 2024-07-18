//
//  Constants.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 18/07/24.
//

import Foundation
import Firebase

struct FirestoreConstants {
    static let UserCollection = Firestore.firestore().collection("users")
    static let MessagesCollecttion = Firestore.firestore().collection("messages")
}
