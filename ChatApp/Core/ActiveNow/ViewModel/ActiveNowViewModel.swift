//
//  ActiveNowViewModel.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 30/07/24.
//

import Foundation
import Firebase

@Observable
class ActiveNowViewModel {
    var users = [User]()
    
    init() {
        Task { try await fetchUsers() }
    }
    
    private func fetchUsers() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAllUser(limit: 10)
        self.users = users.filter({ $0.id != currentUid })
    }
}
