//
//  ProductRow.swift
//  ShoeShop
//
//  Created by Anand Yadav on 21/02/25.
//

import SwiftUI

struct ProductRow: View {
    @EnvironmentObject var cartManager: CartManager
    var cartItem:Cart
    var body: some View {
        HStack {
            Image(cartItem.product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(cartItem.product.name).bold()
                Text("x \(cartItem.quantity)")
                Text("$\(cartItem.product.price * cartItem.quantity).00").bold()
            }
            Spacer()
            Image(systemName: "trash")
                .foregroundStyle(.red)
                .onTapGesture {
                    cartManager.removeFromCart(product: cartItem.product)
                }
        }
        .padding()
    }
}

#Preview {
    ProductRow(cartItem: Cart(product: Product.productList[2], quantity: 2))
        .environmentObject(CartManager())
}
