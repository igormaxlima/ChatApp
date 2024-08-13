//
//  NewMessagesViewModel.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 15/07/24.
//

import Foundation
import Firebase

@Observable class NewMessagesViewModel {
    var users = [User]()
    var searchText = ""
    
    var filteredUsers: [User] {
        if searchText.isEmpty {
            return users
        } else {
            return users.filter { $0.fullname.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    init() {
        Task { try await fetchUsers() }
    }
    
    func fetchUsers() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAllUser()
        self.users = users.filter({ $0.id != currentUid })
    }
}
