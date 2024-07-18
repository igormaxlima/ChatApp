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
        service.observeMessages() { messages in
            self.messages.append(contentsOf: messages)
        }
    }
    
    
    func sendMessage() {
        service.sendMessage(messageText)
    }
}
