//
//  UserDefaultManager.swift
//  Shopping
//
//  Created by Berkay Sancar on 29.07.2024.
//

import Foundation

enum StorageType: String {
    case favorite = "favorite"
    case cart = "cart"
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
        if let data = userDefaults.data(forKey: key.rawValue) {
            do {
                let decodedItem = try decoder.decode(type, from: data)
                return decodedItem
            } catch let DecodingError.dataCorrupted(context) {
                #if DEBUG  
                print(context)
                #endif
            } catch let DecodingError.keyNotFound(key, context) {
                #if DEBUG
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                #endif
            } catch let DecodingError.valueNotFound(value, context) {
                #if DEBUG
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                #endif
            } catch let DecodingError.typeMismatch(type, context)  {
                #if DEBUG
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
                #endif
            } catch {
                #if DEBUG
                print("error: ", error)
                #endif
            }
        }
        return nil
    }
    
    func removeKeyData(key: StorageType) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
