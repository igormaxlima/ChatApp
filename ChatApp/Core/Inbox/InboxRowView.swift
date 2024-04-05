//
//  InboxRowView.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 12/03/24.
//

import SwiftUI

struct InboxRowView: View {
    let user: User
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            CircularProfileImageView(user: user, size: .medium)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Bruce Wayne")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text("Message let me see if sometime they just brake the code for ")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }
            
            HStack {
                Text("Date")
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundStyle(.gray)
            
        }
        .frame(height: 72)
        
    }
}

#Preview {
    InboxRowView(user: User.MOCK_USER)
}
