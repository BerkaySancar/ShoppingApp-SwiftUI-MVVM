//
//  ProfileViewModel.swift
//  Shopping
//
//  Created by Berkay Sancar on 1.08.2024.
//

import Foundation
import DummyAPI

final class ProfileViewModel: ObservableObject {
    
    private let userDefaultsManager: UserDefaultManagerProtocol
    private let dummyAPIService: DummyAPIServiceProtocol
    
    @Published var showActivity = false
    @Published var user: UserModel?
    @Published var showAlert = false
    @Published var turnLogin = false
    
    private(set) var errorMessage: String = ""
    
    init(userDefaultsManager: UserDefaultManagerProtocol = USerDefaultManager(),
         dummyAPIService: DummyAPIServiceProtocol = DummyAPIService()) {
        self.userDefaultsManager = userDefaultsManager
        self.dummyAPIService = dummyAPIService
        
        getAuthUser()
    }
    
    private func getAuthUser() {
        showActivity = true
        
        if let token = userDefaultsManager.getItem(key: .authToken, type: String.self) {
            dummyAPIService.getAuthUser(token: token) { [weak self] results in
                guard let self else { return }
                DispatchQueue.main.async {
                    self.showActivity.toggle()
                    switch results {
                    case .success(let user):
                        self.user = user.map {
                            UserModel(
                                id: $0.id,
                                username: $0.username,
                                email: $0.email,
                                firstName: $0.firstName,
                                lastName: $0.lastName,
                                gender: $0.gender,
                                image: $0.image
                            )
                        }
                    case .failure(let failure):
                        if failure == .unauthorized {
                            if let refreshToken = self.userDefaultsManager.getItem(key: .refreshToken, type: String.self) {
                                self.dummyAPIService.refreshToken(refreshToken: refreshToken, expiresInMins: 1) { results in
                                    switch results {
                                    case .success(let success):
                                        self.userDefaultsManager.addItem(key: .authToken, item: success?.token)
                                        self.userDefaultsManager.addItem(key: .refreshToken, item: success?.refreshToken)
                                    case .failure(let failure):
                                        self.showAlert.toggle()
                                        self.errorMessage = failure.errorDescription
                                    }
                                }
                            }
                        }
                        self.showAlert.toggle()
                        self.errorMessage = failure.errorDescription
                    }
                }
            }
        }
    }
    
    func signOutTapped() {
        userDefaultsManager.removeKeyData(key: .authToken)
        userDefaultsManager.removeKeyData(key: .refreshToken)
        self.turnLogin.toggle()
    }
}