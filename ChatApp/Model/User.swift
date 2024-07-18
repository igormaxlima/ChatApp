//
//  User.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 17/03/24.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable, Hashable {
    @DocumentID var uid: String?
    let fullname: String
    let email: String
    var profileImageUrl: String?
    
    var id: String {
        return uid ?? NSUUID().uuidString
    }
}

extension User {
    static let MOCK_USER = User(fullname: "Andrew Garfield", email: "spiderman@gmail.com")
}
