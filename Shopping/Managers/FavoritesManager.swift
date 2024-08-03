//
//  FavoritesManager.swift
//  Shopping
//
//  Created by Berkay Sancar on 30.07.2024.
//

import Foundation

protocol FavoritesManagerProtocol: AnyObject {
    var favorites: [Product] { get set }
    var favoritesPublisher: Published<[Product]>.Publisher { get }
    
    func addToFavorite(product: Product)
    func getFavorites()
    func removeFromFavorites(productId: Int)
    func isAlreadyFavorite(product: Product) -> Bool
    func save() 
}

final class FavoritesManager: ObservableObject, FavoritesManagerProtocol {

    private let userDefaultManager: UserDefaultManagerProtocol
    
    @Published var favorites: [Product] = []
    var favoritesPublisher: Published<[Product]>.Publisher { $favorites }
    
    init(userDefaultManager: UserDefaultManagerProtocol = USerDefaultManager()) {
        self.userDefaultManager = userDefaultManager
        
        getFavorites()
    }
    
    func addToFavorite(product: Product) {
        self.favorites.append(product)
        
        save()
    }
    
    func getFavorites() {
        self.favorites = userDefaultManager.getItem(key: .favorite, type: [Product].self) ?? []
    }
    
    func removeFromFavorites(productId: Int) {
        self.favorites.removeAll(where: {$0.id == productId })
        save()
    }
    
    func isAlreadyFavorite(product: Product) -> Bool {
        return self.favorites.contains(where: {$0.id == product.id})
    }
    
    func save() {
        userDefaultManager.addItem(key: .favorite, item: self.favorites)
    }
}
