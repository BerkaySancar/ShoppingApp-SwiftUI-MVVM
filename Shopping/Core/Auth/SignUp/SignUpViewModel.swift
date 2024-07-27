//
//  SignUpViewModel.swift
//  Shopping
//
//  Created by Berkay Sancar on 27.07.2024.
//

import Foundation
import DummyAPI

enum ActiveAlert {
    case userCreated, emptyInfo, userNotCreated
}

protocol SignUpViewModelProtocol {
    func createUserTapped()
}

final class SignUpViewModel: ObservableObject, SignUpViewModelProtocol {
    
    private let dummyService: DummyAPIServiceProtocol
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var showActivity = false
    @Published var activeAlert: ActiveAlert = .userCreated
    @Published var showAlert = false
    
    private(set) var errorMessage = ""
    
    init(dummyService: DummyAPIServiceProtocol = DummyAPIService()) {
        self.dummyService = dummyService
    }
    
    func createUserTapped() {
        if !username.isEmpty,
           !password.isEmpty,
           !lastName.isEmpty,
           !firstName.isEmpty,
           !email.isEmpty {
            self.showActivity = true
            dummyService.createUser(firstname: firstName,
                                    lastname: lastName,
                                    username: username,
                                    password: password) { [weak self] results in
                guard let self else { return }
                DispatchQueue.main.async {
                    self.showActivity = false
                    switch results {
                    case .success(_):
                        self.activeAlert = .userCreated
                        self.showAlert.toggle()
                    case .failure(let failure):
                        self.errorMessage = failure.errorDescription
                        self.activeAlert = .userNotCreated
                        self.showAlert.toggle()
                    }
                }
            }
        } else {
            self.errorMessage = "Please fill in the information completely."
            self.activeAlert = .emptyInfo
            self.showAlert.toggle()
        }
    }
}
