//
//  LoginViewModel.swift
//  Shopping
//
//  Created by Berkay Sancar on 27.07.2024.
//

import Foundation
import DummyAPI

protocol LoginViewModelProtocol {
    func loginTapped()
    func signUpTapped()
}

final class LoginViewModel: ObservableObject, LoginViewModelProtocol {
    
    private let service: DummyAPIServiceProtocol
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn = false
    @Published var isPresentAlert = false
    @Published var showSignup = false
    private(set) var errorMessage: String = ""
    
    init(service: DummyAPIServiceProtocol = DummyAPIService()) {
        self.service = service
    }
    
    func loginTapped() {
        if !username.isEmpty && !password.isEmpty {
            service.login(username: self.username, password: self.password) { [weak self] results in
                guard let self else { return }
                DispatchQueue.main.async {
                    switch results {
                    case .success(_):
                        self.isLoggedIn.toggle()
                    case .failure(let failure):
                        self.errorMessage = failure.errorDescription
                        self.isPresentAlert.toggle()
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.isPresentAlert.toggle()
                self.errorMessage = "Email or password cannot be empty."
            }
        }
    }
    
    func signUpTapped() {
        DispatchQueue.main.async { [weak self] in
            self?.showSignup.toggle()
        }
    }
}
