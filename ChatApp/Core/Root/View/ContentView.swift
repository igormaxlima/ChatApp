//
//  ContentView.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 12/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var contentViewModel = ContentViewModel()
    
    var body: some View {
        Group {
            if (contentViewModel.userSession != nil) {
                InboxView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
