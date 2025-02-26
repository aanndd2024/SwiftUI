//
//  CartManager.swift
//  ShoeShop
//
//  Created by Anand Yadav on 18/02/25.
//

import Foundation

class CartManager: ObservableObject {
    @Published var items:[Cart] = []
    @Published var count:Int = 0
    @Published var total:Int = 0
    
    func addToCart(product:Product) {
        if let productIndex = items.firstIndex(where: { item in
            item.product.id == product.id
        }) {
            items[productIndex].quantity += 1
            total += product.price
            count += 1
            return
        }
        
        let cartItem = Cart(product: product, quantity: 1)
        items.append(cartItem)
        total += product.price
        count += 1
    }
    
    func removeFromCart(product:Product) {
        if let itemIndex = items.firstIndex(where: { item in
            item.product.id == product.id
        }) {
            let itemToRemove = items[itemIndex].product
        }
    }
    
//    func getCartItem(by product:Product) -> Cart {
//        
//    }
}
