//
//  CartManager.swift
//  Shopping
//
//  Created by Berkay Sancar on 31.07.2024.
//

import Foundation

protocol CartManagerProtocol: AnyObject {
    var cartItemsPublisher: Published<[CartModel]>.Publisher { get }
    
    func addToCart(item: CartModel)
    func getCartItems()
    func removeFromCart(item: CartModel)
    func isAlreadyInCart(item: CartModel) -> Bool
    func updateItem(item: CartModel, count: Int)
}

final class CartManager: CartManagerProtocol, ObservableObject {
   
    private let userDefaultsManager: UserDefaultManagerProtocol
    
    @Published var cartItems: [CartModel] = []
    var cartItemsPublisher: Published<[CartModel]>.Publisher { $cartItems }
    
    init(userDefaultsManager: UserDefaultManagerProtocol = USerDefaultManager()) {
        self.userDefaultsManager = userDefaultsManager
        
        getCartItems()
    }
    
    func addToCart(item: CartModel) {
        if !isAlreadyInCart(item: item) {
            self.cartItems.append(item)
        }
        save()
    }
    
    func getCartItems() {
        self.cartItems = userDefaultsManager.getItem(key: .cart, type: [CartModel].self) ?? []
    }
    
    func removeFromCart(item: CartModel) {
        if self.cartItems.contains(where: { $0.id == item.id }) {
            self.cartItems.removeAll(where: { $0.id == item.id })
        }
        save()
    }
    
    func isAlreadyInCart(item: CartModel) -> Bool {
        return self.cartItems.contains(where: {$0.id == item.id})
    }
    
    private func save() {
        self.userDefaultsManager.addItem(key: .cart, item: self.cartItems)
    }
    
    func updateItem(item: CartModel, count: Int) {
//        self.cartItems.filter { $0.id == item.id }.first?.count = count
//        self.cartItems.filter { $0.id == item.id }.first?.price = total
        
//        save()
    }
}
