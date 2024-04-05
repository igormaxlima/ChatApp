//
//  RegistrationView.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 12/03/24.
//

import SwiftUI

struct RegistrationView: View {
    @State var registrationViewModel = RegistrationViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            //logo image
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 180)
                .padding()
                .shadow(radius: 10, x: 5, y: 10)
            
            // text fields
            VStack(spacing: 12) {
                TextField("Enter your email", text: $registrationViewModel.email)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal, 24)
                
                TextField("Enter your full name", text: $registrationViewModel.fullname)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal, 24)

                SecureField("Enter your password", text: $registrationViewModel.password)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal, 24)
                    
            }
            
            
            // login button
            Button {
                Task { try await registrationViewModel.createUser() }
            } label: {
                Text("Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 360, height: 40)
                    .background(Color(.systemBlue))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
            }
            .padding(.vertical)
            
            Spacer()
                
            Divider()
            // sign up link
            Button {
               dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                    
                    Text("Sign in")
                        .fontWeight(.semibold)
                }
                .font(.footnote)
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    RegistrationView()
}
