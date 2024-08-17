//
//  ProductDetailVM.swift
//  Shopping
//
//  Created by Berkay Sancar on 30.07.2024.
//

import Foundation
import DummyAPI

final class ProductDetailVM: ObservableObject {
    
    var product: Product! {
        didSet {
            self.isFav = favoritesManager.isAlreadyFavorite(product: product)
        }
    }
    
    private let favoritesManager: FavoritesManagerProtocol
    private let cartManager: CartManagerProtocol
    private let dummyAPIService: DummyAPIServiceProtocol

    @Published var isFav: Bool = false
    @Published var showActivity = false
    @Published var showAlert = false
    
    private(set) var errorMessage: String = ""
    
    init(
        favoritesManager: FavoritesManagerProtocol = FavoritesManager(),
        cartManager: CartManagerProtocol = CartManager(),
        dummyAPIService: DummyAPIServiceProtocol = DummyAPIService()
    ) {
        self.favoritesManager = favoritesManager
        self.cartManager = cartManager
        self.dummyAPIService = dummyAPIService
    }
    
    func addRemoveFavTapped(product: Product) {
        isFav.toggle()
        
        favoritesManager.isAlreadyFavorite(
            product: product
        ) ? favoritesManager.removeFromFavorites(
            productId: product.id
        ) : favoritesManager.addToFavorite(
            product: product
        )
    }
    
    func addToCartTapped(completion: @escaping () -> Void) {
        let cartModel = CartModel()
        cartModel.id = product.id
        cartModel.count = product.count
        cartModel.brand = product.brand ?? ""
        cartModel.images = product.images
        cartModel.price = product.price
        cartModel.title = product.title
        cartModel.count = 1
        
        cartManager.addToCart(item: cartModel)
        
        completion()
    }
}
