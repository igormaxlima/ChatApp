//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 16/07/24.
//

import Foundation

@Observable class ChatViewModel {
    var messageText = ""
    var messages = [Message]()
    
    let service: ChatService
    
    init(user: User) {
        self.service = ChatService(chatPartner: user)
        observeMessages()
    }
    
    func observeMessages() {
        service.observeMessages { [weak self] messages in
            guard let self = self else { return }
            
            for message in messages {
                if let index = self.messages.firstIndex(where: { $0.id == message.id }) {
                    self.messages[index] = message
                } else {
                    self.messages.append(message)
                }
            }
            
            self.readMessages()
        }
    }
    
    
    func sendMessage() {
        service.sendMessage(messageText)
    }
    
    func readMessages() {
        Task { try await service.markMessagesAsRead() }
    }
}
