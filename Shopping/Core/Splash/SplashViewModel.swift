//
//  SplashViewModel.swift
//  Shopping
//
//  Created by Berkay Sancar on 27.07.2024.
//

import Foundation
import SystemConfiguration
import DummyAPI

@MainActor
final class SplashViewModel: ObservableObject {
    
    private let dummyAPIService: DummyAPIServiceProtocol
    private let userDefaultsManager: UserDefaultManagerProtocol
    @Published var presentConnectionAlert = false
    @Published var isAuthUser = false
    @Published var shouldLogin = false
    
    private var isNetworkReachable: Bool {
        checkReachability()
    }
    
    init(dummyAPIService: DummyAPIServiceProtocol = DummyAPIService(),
         userDefaultManager: UserDefaultManagerProtocol = USerDefaultManager()) {
        self.dummyAPIService = dummyAPIService
        self.userDefaultsManager = userDefaultManager
    }
    
    private func checkReachability() -> Bool {
        if let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com") {
            var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags()
            SCNetworkReachabilityGetFlags(reachability, &flags)
            
            return flags.contains(.reachable) && !flags.contains(.connectionRequired)
        }
        return false
    }
    
    func manageSplashAction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self else { return }
            if self.isNetworkReachable {
                if let token = userDefaultsManager.getItem(key: .authToken, type: String.self) {
                    dummyAPIService.getAuthUser(token: token) { results in
                        switch results {
                        case .success(_):
                            self.isAuthUser = true
                        case .failure(let failure):
                            switch failure {
                            case .unauthorized:
                                if let refreshToken = self.userDefaultsManager.getItem(key: .refreshToken, type: String.self) {
                                    self.dummyAPIService.refreshToken(refreshToken: refreshToken, expiresInMins: 1) { results in
                                        switch results {
                                        case .success(let success):
                                            self.userDefaultsManager.addItem(key: .authToken, item: success?.token)
                                            self.userDefaultsManager.addItem(key: .refreshToken, item: success?.refreshToken)
                                            self.isAuthUser = true
                                        case .failure(_):
                                            self.shouldLogin = true
                                        }
                                    }
                                }
                            default:
                                self.shouldLogin = true
                            }
                        }
                    }
                } else {
                    self.shouldLogin = true
                }
            } else {
                self.presentConnectionAlert.toggle()
            }
        }
    }
}
