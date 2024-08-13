//
//  InboxView.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 12/03/24.
//

import SwiftUI

struct InboxView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isShowingNewMessageView = false
    @State var inboxViewModel = InboxViewModel()
    @State private var selectedUser: User?
    @State private var showChat = false
    
    private var user: User? {
        return inboxViewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            if ((inboxViewModel.currentUser == nil) && inboxViewModel.recentMessages.isEmpty) {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                List {
                    ActiveNowView()
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                        .padding(.vertical, 8)
                        .padding(.horizontal, 4)
                    
                    ForEach(inboxViewModel.filteredRecentMessages) { message in
                        ZStack {
                            NavigationLink(value: message) {
                                EmptyView()
                            }.opacity(0.0)
                            
                            InboxRowView(message: message)
                        }
                    }
                    .onDelete { offsets in
                        if let index = offsets.first {
                            inboxViewModel.deleteChat(at: index)
                        }
                    }
                }
                .searchable(text: $inboxViewModel.searchText, prompt: "Search Chats")
                .navigationTitle("Chats")
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(PlainListStyle())
                .onChange(of: selectedUser, { _, newValue in
                    showChat = newValue != nil
                })
                // for: tipo de objeto que sera passado para o destino da navegacao
                // when you get this piece of data (for), do this (destination)
                .navigationDestination(for: Route.self, destination: { route in
                    switch route {
                    case .profile(let user):
                        ProfileView(user: user)
                    case .chatView(let user):
                        ChatView(user: user)
                    }
                })
                .navigationDestination(for: Message.self, destination: { message in
                    if let user = message.user {
                        ChatView(user: user)
                    }
                })
                .navigationDestination(isPresented: $showChat, destination: {
                    if let user = selectedUser {
                        ChatView(user: user)
                    }
                })
                .fullScreenCover(isPresented: $isShowingNewMessageView, content: {
                    NewMessageView(selectedUser: $selectedUser)
                })
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        // value: parsing data through the navigation
                        if let user {
                            NavigationLink(value: Route.profile(user)) {
                                CircularProfileImageView(user: user, size: .xSmall)
                                    .padding(.bottom, 8)
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isShowingNewMessageView.toggle()
                            selectedUser = nil
                        } label: {
                            Image(systemName: "square.and.pencil.circle.fill")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .foregroundStyle(colorScheme == .light ? .black : .white, Color(.systemGray5))
                                .padding(.bottom, 8)
                        }
                    }
                }
                .overlay {
                    if (inboxViewModel.recentMessages.isEmpty) {
                        ContentUnavailableView("No Chats", systemImage: "bubble.left.and.exclamationmark.bubble.right", description: Text("Tap on a user to start a chat."))
                    } else if inboxViewModel.filteredRecentMessages.isEmpty {
                        ContentUnavailableView.search
                    }
                }
                
            }
        }
    }
}

#Preview {
    InboxView()
}
