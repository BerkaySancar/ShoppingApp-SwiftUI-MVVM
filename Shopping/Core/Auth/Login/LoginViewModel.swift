//
//  LoginViewModel.swift
//  Shopping
//
//  Created by Berkay Sancar on 27.07.2024.
//

import Foundation

extension LoginView {
    
    final class LoginViewModel: ObservableObject {
        
        @Published var username: String = ""
        @Published var password: String = ""
    }
}
