//
//  LoginViewModel.swift
//  Shopping
//
//  Created by Berkay Sancar on 27.07.2024.
//

import Foundation
import DummyAPI

protocol LoginViewModelProtocol {
    func loginTapped(completion: @escaping (_ isSuccess: Bool) -> Void)
    func signUpTapped()
}

final class LoginViewModel: ObservableObject {
    
    //Dependencies
    private let service: DummyAPIServiceProtocol
    private let userDefaultManager: UserDefaultManagerProtocol
    
    //Published variables
    @Published var username: String = "emilys"
    @Published var password: String = "emilyspass"
    @Published var isPresentAlert = false
    @Published var showSignup = false
    @Published var showActivity = false
    
    //Variables
    private(set) var errorMessage: String = ""
    
    //Init
    init(service: DummyAPIServiceProtocol = DummyAPIService(),
         userDefaultsManager: UserDefaultManagerProtocol = USerDefaultManager()) {
        self.service = service
        self.userDefaultManager = userDefaultsManager
    }
}

//MARK: ViewModel Protocols
extension LoginViewModel: LoginViewModelProtocol {
    
    func loginTapped(completion: @escaping (_ isSuccess: Bool) -> Void) {
        if !username.isEmpty && !password.isEmpty {
            self.showActivity = true
            service.login(username: self.username, password: self.password) { [weak self] results in
                guard let self else { return }
                DispatchQueue.main.async {
                    self.showActivity = false
                    switch results {
                    case .success(let login):
                        completion(true)
                        self.userDefaultManager.addItem(key: .authToken, item: login?.token)
                        self.userDefaultManager.addItem(key: .refreshToken, item: login?.refreshToken)
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
