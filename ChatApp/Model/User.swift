//
//  User.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 17/03/24.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    var id = NSUUID().uuidString
    let fullname: String
    let email: String
    let password: String
    var profileImageUrl: String?
}

extension User {
    static let MOCK_USER = User(fullname: "Andrew Garfield", email: "spiderman@gmail.com", password: "spider123")
}
