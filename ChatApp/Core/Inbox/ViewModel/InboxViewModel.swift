//
//  InboxViewModel.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 11/07/24.
//

import Foundation
import Combine
import Firebase

@Observable class InboxViewModel {
    var currentUser: User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] userFromUserService in
            self?.currentUser = userFromUserService
        }.store(in: &cancellables)
    }
}
