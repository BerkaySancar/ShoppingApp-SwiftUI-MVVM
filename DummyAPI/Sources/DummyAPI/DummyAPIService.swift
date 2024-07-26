//
//  File.swift
//  
//
//  Created by Berkay Sancar on 26.07.2024.
//

import Foundation

public protocol DummyAPIServiceProtocol {
    func createUser(user: AddUserDTO, completion: @escaping (Result<LoginDTO?, ServiceError>) -> Void)
}

@available(iOS 15.0, *)
public final class DummyAPIService: DummyAPIServiceProtocol {
    
    private let networkManager: NetworkManager
    
    public init() {
        self.networkManager = NetworkManager()
    }
    
    public func createUser(user: AddUserDTO, completion: @escaping (Result<LoginDTO?, ServiceError>) -> Void) {
        networkManager.request(DummyAPI.addUser(user), type: LoginDTO.self) { [weak self] results in
            guard let self else { return }
            switch results {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
