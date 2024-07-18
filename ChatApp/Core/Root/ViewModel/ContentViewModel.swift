//
//  ContentViewModel.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 08/04/24.
//

import Firebase
import Combine

@Observable class ContentViewModel {
    var userSession: Firebase.User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        AuthService.shared.$userSession.sink { [weak self] userFromAuthService in
            self?.userSession = userFromAuthService
        }.store(in: &cancellables)
    }
}
