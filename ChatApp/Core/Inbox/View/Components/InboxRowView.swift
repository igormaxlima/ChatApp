//
//  InboxRowView.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 12/03/24.
//

import SwiftUI

struct InboxRowView: View {
    @Environment(\.colorScheme) var colorScheme
    let message: Message
    
    private var isUnreadMessage: Bool {
        return !message.isFromCurrentUser && message.isRead == false
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            CircularProfileImageView(user: message.user, size: .medium)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(message.user?.fullname ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text("\(message.isFromCurrentUser ? "You: " : "")" + message.messageText)
                    .font(.subheadline)
                    .fontWeight(isUnreadMessage ? .semibold : .regular)
                    .foregroundStyle(isUnreadMessage ? (colorScheme == .dark ? .white : .black) : .gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }
            
            
            VStack(spacing: 10) {
                HStack {
                    Text(message.timestampString)
                    Image(systemName: "chevron.right")
                }
                .font(.footnote)
                .foregroundStyle(.gray)
                
                if isUnreadMessage {
                    ZStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 10, height: 10)
                    }
                    
                }

            }
                        
        }
        .frame(height: 72)
        
    }
}

#Preview {
    InboxRowView(message: Message.MESSAGE_MOCK)
}
