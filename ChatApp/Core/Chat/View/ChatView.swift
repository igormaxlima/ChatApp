//
//  ChatView.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 22/03/24.
//

import SwiftUI

struct ChatView: View {
    @State var chatViewModel: ChatViewModel
    let user: User
    
    init(user: User) {
        self.user = user
        // backing property para armazenar o estado interno do wrapper
        self._chatViewModel = State(wrappedValue: ChatViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                // header:
                VStack(spacing: 8) {
                    CircularProfileImageView(user: user, size: .xLarge)
                    
                    VStack(spacing: 4) {
                        Text(user.fullname)
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("Messenger")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }

                }
                
                // messages
                
                LazyVStack {
                    ForEach(chatViewModel.messages) { message in
                        ChatMessageCell(message: message)
                    }
                }
                
            }
            
            // message input view
            Spacer()
            
            ZStack(alignment: .trailing) {
                TextField("Message...", text: $chatViewModel.messageText, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 48)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(.rect(cornerRadius: 15))
                    .font(.subheadline)
                
                Button {
                    chatViewModel.sendMessage()
                    chatViewModel.messageText = ""
                } label: {
                    Text("Send")
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .navigationTitle(user.fullname)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ChatView(user: User.MOCK_USER)
}
