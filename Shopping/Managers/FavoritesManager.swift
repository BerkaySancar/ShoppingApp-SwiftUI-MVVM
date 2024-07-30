//
//  FavoritesManager.swift
//  Shopping
//
//  Created by Berkay Sancar on 30.07.2024.
//

import Foundation

protocol FavoritesManagerProtocol: AnyObject {
    var favorites: [FavoriteProduct] { get set }
    
    func addToFavorite(product: Product)
    func getFavorites()
    func removeFromFavorites(product: Product)
    func isAlreadyFavorite(product: Product) -> Bool
    func save() 
}

final class FavoritesManager: ObservableObject, FavoritesManagerProtocol {
    
    private let userDefaultManager: UserDefaultManagerProtocol
    
    @Published var favorites: [FavoriteProduct] = []
    
    init(userDefaultManager: UserDefaultManagerProtocol = USerDefaultManager()) {
        self.userDefaultManager = userDefaultManager
        
        getFavorites()
    }
    
    func addToFavorite(product: Product) {
        let favorite = FavoriteProduct(
            id: product.id,
            title: product.title,
            price: product.price,
            images: product.images
        )
        self.favorites.append(favorite)
        
        save()
    }
    
    func getFavorites() {
        self.favorites = userDefaultManager.getItem(key: .favorite, type: [FavoriteProduct].self) ?? []
    }
    
    func removeFromFavorites(product: Product) {
        if self.favorites.contains(where: {$0.id == product.id}) {
            self.favorites.removeAll(where: {$0.id == product.id})
        }
        save()
    }
    
    func isAlreadyFavorite(product: Product) -> Bool {
        return self.favorites.contains(where: {$0.id == product.id})
    }
    
    func save() {
        userDefaultManager.addItem(key: .favorite, item: self.favorites)
    }
}
