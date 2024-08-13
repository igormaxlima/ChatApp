//
//  ProfileView.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 12/03/24.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @State var profileViewModel = ProfileViewModel()
    let user: User
    
    var body: some View {
        VStack {
            VStack {
                PhotosPicker(selection: $profileViewModel.selectedPhoto, matching: .images) {
                    
                    if let profileImage = profileViewModel.profileImage { profileImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    } else {
                        CircularProfileImageView(user: user, size: .xLarge)
                    }
                }
                
                Text(user.fullname)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            List {
                Section {
                    ForEach(SettingsOptions.allCases) { setting in
                        HStack {
                            Image(systemName: setting.imageName)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(setting.imageBackgroundColor)
                            
                            
                            Text(setting.title)
                                .font(.subheadline)
                        }
                    }
                }
                
                Section {
                    Button("Log Out") {
                        AuthService.shared.signOut()
                    }
                    
                    Button("Delete Account") {
                        
                    }
                }
                .foregroundStyle(.red)
            }
            
        }
    }
}

#Preview {
    ProfileView(user: User.MOCK_USER)
}
