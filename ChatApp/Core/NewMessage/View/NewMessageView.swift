//
//  NewMessageView.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 12/03/24.
//

import SwiftUI

struct NewMessageView: View {
    @State private var newMessagesViewModel = NewMessagesViewModel()
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedUser: User?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                TextField("To: ", text: $newMessagesViewModel.searchText)
                    .frame(height: 44)
                    .padding(.leading)
                    .background(Color(.systemGroupedBackground))
                
                Text("CONTACTS")
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                ForEach(newMessagesViewModel.filteredUsers) { user in
                    VStack {
                        HStack {
                            CircularProfileImageView(user: user, size: .small)
                            
                            Text(user.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding(.leading)
                        
                        Divider()
                            .padding(.leading, 40)
                    }
                    .onTapGesture {
                        selectedUser = user
                        dismiss()
                    }
                    
                }
                
            }
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                }
            }
            .overlay {
                if newMessagesViewModel.filteredUsers.isEmpty {
                    ContentUnavailableView.search
                }
            }
        }
    }
}

#Preview {
    NewMessageView(selectedUser: .constant(User.MOCK_USER))
}
