//
//  Cart.swift
//  ShoeShop
//
//  Created by Anand Yadav on 18/02/25.
//

import Foundation

struct Cart: Identifiable {
    var id = UUID()
    var product: Product
    var quantity: Int
}
