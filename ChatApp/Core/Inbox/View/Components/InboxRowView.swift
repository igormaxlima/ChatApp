//
//  InboxRowView.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 12/03/24.
//

import SwiftUI

struct InboxRowView: View {
    let message: Message
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if (!message.isFromCurrentUser && message.isRead == false) {
                ZStack {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 8, height: 10)
                }
                .frame(width: 10, height: 72)
            }
            
            CircularProfileImageView(user: message.user, size: .medium)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(message.user?.fullname ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text("\(message.isFromCurrentUser ? "You: " : "")" + message.messageText)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }
            
            HStack {
                Text(message.timestampString)
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundStyle(.gray)
            
        }
        .frame(height: 72)
        
    }
}

#Preview {
    InboxRowView(message: Message.MESSAGE_MOCK)
}
