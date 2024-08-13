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
    var recentMessages = [Message]()
    var searchText = ""
    
    var filteredRecentMessages: [Message] {
        if searchText.isEmpty {
            return recentMessages
        } else {
            return recentMessages.filter { $0.user?.fullname.lowercased().contains(searchText.lowercased()) ?? false }
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    private let service = InboxService()
    
    init() {
        setupSubscribers()
        service.observeRecentMessages()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] userFromUserService in
            self?.currentUser = userFromUserService
        }.store(in: &cancellables)
        
        
        service.$documentChanges.sink { [weak self] changes in
            self?.loadInitialMessages(fromChanges: changes)
        }.store(in: &cancellables)
    }
    
    private func loadInitialMessages(fromChanges changes: [DocumentChange]) {
        var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
        for i in 0 ..< messages.count {
            let message = messages[i]
            
            UserService.fetchUser(withUid: message.chatPartnerId) { user in
                messages[i].user = user
                
                if let index = self.recentMessages.firstIndex(where: { $0.id == message.id }) {
                    self.recentMessages[index] = messages[i]
                } else {
                    self.recentMessages.append(messages[i])
                }
                
                self.sortRecentMessages()
            }
        }
    }
    
    private func sortRecentMessages() {
        self.recentMessages.sort { $0.timestamp.dateValue() > $1.timestamp.dateValue() }
    }
    
    func deleteChat(at index: Int) {
        Task {
            let messageToDelete = filteredRecentMessages[index]
            
            
            if let originalIndex = recentMessages.firstIndex(where: { $0.id == messageToDelete.id }) {
                if let chatPartnerUser = recentMessages[originalIndex].user {
                    try await service.deleteMessages(chatPartner: chatPartnerUser)
                }
                self.recentMessages.remove(at: originalIndex)
            }
        }
    }
    
}
