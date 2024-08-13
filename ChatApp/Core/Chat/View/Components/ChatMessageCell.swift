//
//  ChatMessageCell.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 22/03/24.
//

import SwiftUI

struct ChatMessageCell: View {
    @Environment(\.colorScheme) var colorScheme
    let message: Message
    
    private var isFromCurrentUser: Bool {
        return message.isFromCurrentUser
    }
    
    var body: some View {
        HStack {
            if isFromCurrentUser {
                Spacer()
                
                HStack(alignment: .bottom, spacing: 4) {
                    Text(message.messageText)
                        .font(.subheadline)
                        .padding(12)
                        .padding(.trailing, 0)
                        .foregroundStyle(.white)
                        
                    Image(systemName: "checkmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12)
                        .foregroundStyle(Color(message.isRead ? .green : .white))
                        .padding(.trailing, 10)
                        .padding(.bottom, 10)

                }
                .background(Color(.systemBlue))
                .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
            } else {
                HStack(alignment: .bottom, spacing: 8){
                    CircularProfileImageView(user: message.user, size: .xxSmall)
                    
                    Text(message.messageText)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray5))
                        .foregroundStyle(colorScheme == .light ? .black : .white)
                        .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .leading)
                }
                Spacer()
            }
        }
        .padding(.horizontal, 8)
    }
}


#Preview {
    ChatMessageCell(message: Message.MESSAGE_MOCK)
}
