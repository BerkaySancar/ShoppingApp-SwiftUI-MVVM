//
//  File.swift
//  
//
//  Created by Berkay Sancar on 26.07.2024.
//

import Foundation

public protocol DummyAPIServiceProtocol {
    func createUser(firstname: String,
                    lastname: String,
                    username: String,
                    password: String,
                    completion: @escaping (Result<LoginRequestDTO?, ServiceError>) -> Void)
    func login(username: String,
               password: String,
               completion: @escaping (Result<LoginResponseDTO?, ServiceError>) -> Void)
    func getProducts(completion: @escaping (Result<[Product]?, ServiceError>) -> Void)
    func searchProducts(query: String,
                        completion: @escaping (Result<[Product]?, ServiceError>) -> Void)
    func getCategories(completion: @escaping (Result<[String]?, ServiceError>) -> Void)
    func getCategoryProducts(category: String, completion: @escaping (Result<[Product]?, ServiceError>) -> Void)
    func getAuthUser(token: String, completion: @escaping (Result<UserDTO?, ServiceError>) -> Void)
    func refreshToken(refreshToken: String, expiresInMins: Int, completion: @escaping (Result<TokenDTO?, ServiceError>) -> Void)
}

@available(iOS 15.0, *)
public final class DummyAPIService: DummyAPIServiceProtocol {
    
    private let serviceManager: ServiceManager
    
    public init() {
        self.serviceManager = ServiceManager()
    }
    
    public func createUser(firstname: String,
                           lastname: String,
                           username: String,
                           password: String,
                           completion: @escaping (Result<LoginRequestDTO?, ServiceError>) -> Void) {
        let user = AddUserDTO(firstName: firstname, lastName: lastname, username: username, password: password)
        serviceManager.request(DummyAPI.addUser(user), type: LoginRequestDTO.self) { results in
            switch results {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    public func login(username: String,
                      password: String,
                      completion: @escaping (Result<LoginResponseDTO?, ServiceError>) -> Void) {
        serviceManager.request(DummyAPI.login(LoginRequestDTO(username: username, password: password, expiresInMins: 1)), type: LoginResponseDTO.self) { results in
            switch results {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    public func refreshToken(refreshToken: String, expiresInMins: Int, completion: @escaping (Result<TokenDTO?, ServiceError>) -> Void) {
        serviceManager.request(DummyAPI.refreshToken(.init(refreshToken: refreshToken, expiresInMins: expiresInMins)), type: TokenDTO.self) { results in
            switch results {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    public func getAuthUser(token: String, completion: @escaping (Result<UserDTO?, ServiceError>) -> Void) {
        serviceManager.request(DummyAPI.authUser(token), type: UserDTO.self) { results in
            switch results {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    public func getProducts(completion: @escaping (Result<[Product]?, ServiceError>) -> Void) {
        serviceManager.request(DummyAPI.products, type: Products.self) { results in
            switch results {
            case .success(let success):
                completion(.success(success?.products))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    public func searchProducts(query: String, completion: @escaping (Result<[Product]?, ServiceError>) -> Void) {
        serviceManager.request(DummyAPI.searchProduct(query), type: Products.self) { results in
            switch results {
            case .success(let success):
                completion(.success(success?.products))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    public func getCategories(completion: @escaping (Result<[String]?, ServiceError>) -> Void) {
        serviceManager.request(DummyAPI.categories, type: [String].self) { results in
            switch results {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    public func getCategoryProducts(category: String, completion: @escaping (Result<[Product]?, ServiceError>) -> Void) {
        serviceManager.request(DummyAPI.getCategoryProducts(category), type: Products.self) { results in
            switch results {
            case .success(let success):
                completion(.success(success?.products))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
