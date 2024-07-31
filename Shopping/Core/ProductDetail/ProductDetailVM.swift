//
//  ProductDetailVM.swift
//  Shopping
//
//  Created by Berkay Sancar on 30.07.2024.
//

import Foundation

final class ProductDetailVM: ObservableObject {
    
    var product: Product! {
        didSet {
            self.isFav = favoritesManager.favorites.contains(where: { $0.id == product.id })
        }
    }
  
    private let favoritesManager: FavoritesManagerProtocol
    private let cartManager: CartManagerProtocol

    @Published var isFav: Bool = false
    @Published var navigateCart = false
    
    init(
        favoritesManager: FavoritesManagerProtocol = FavoritesManager(),
        cartManager: CartManagerProtocol = CartManager()
    ) {
        self.favoritesManager = favoritesManager
        self.cartManager = cartManager
    }
    
    
    func addRemoveFavTapped(product: Product) {
        isFav.toggle()
        
        favoritesManager.isAlreadyFavorite(
            product: product
        ) ? favoritesManager.removeFromFavorites(
            product: product
        ) : favoritesManager.addToFavorite(
            product: product
        )
    }
    
    func addToCartTapped() {
        let cartModel = CartModel()
        cartModel.id = product.id
        cartModel.count = product.count
        cartModel.brand = product.brand ?? ""
        cartModel.images = product.images
        cartModel.price = product.price
        cartModel.title = product.title
        cartModel.count = 1
        
        cartManager.addToCart(item: cartModel)
        
        navigateCart.toggle()
    }
}
