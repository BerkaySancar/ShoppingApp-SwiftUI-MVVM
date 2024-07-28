//
//  SplashViewModel.swift
//  Shopping
//
//  Created by Berkay Sancar on 27.07.2024.
//

import Foundation
import SystemConfiguration


final class SplashViewModel: ObservableObject {
    
    @Published var isSplashComplete = false
    @Published var presentConnectionAlert = false
    
    private var isNetworkReachable: Bool {
        checkReachability()
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
            if self.isNetworkReachable == true {
                self.isSplashComplete = true
            } else {
                self.isSplashComplete = false
                self.presentConnectionAlert.toggle()
            }
        }
    }
}

