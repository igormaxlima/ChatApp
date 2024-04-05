//
//  RegistrationViewModel.swift
//  ChatApp
//
//  Created by Igor Max de Lima Nunes on 05/04/24.
//

import SwiftUI

@Observable class RegistrationViewModel {
    
    var email: String = ""
    var password: String = ""
    var fullname: String = ""
    
    func createUser() async throws {
        try await AuthService().createUser(withEmail: self.email, password: self.password, fullname: self.fullname)
    }
    
}
