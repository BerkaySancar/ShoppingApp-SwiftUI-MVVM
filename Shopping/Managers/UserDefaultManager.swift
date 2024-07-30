//
//  UserDefaultManager.swift
//  Shopping
//
//  Created by Berkay Sancar on 29.07.2024.
//

import Foundation

enum StorageType: String {
    case favorite = "favorite"
}

protocol UserDefaultManagerProtocol: AnyObject {
    func addItem<T: Codable>(key: StorageType, item: T)
    func getItem<T: Codable>(key: StorageType, type: T.Type) -> T?
    func removeKeyData(key: StorageType)
}

final class USerDefaultManager: UserDefaultManagerProtocol {
    
    private let userDefaults = UserDefaults.standard
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    func addItem<T: Codable>(key: StorageType, item: T) {
        let encodedData = try? encoder.encode(item)
        userDefaults.set(encodedData, forKey: key.rawValue)
    }
    
    func getItem<T: Codable>(key: StorageType, type: T.Type) -> T? {
        if let data = userDefaults.data(forKey: key.rawValue),
           let decodedItem = try? decoder.decode(type, from: data) {
            return decodedItem
        }
        return nil
    }
    
    func removeKeyData(key: StorageType) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
