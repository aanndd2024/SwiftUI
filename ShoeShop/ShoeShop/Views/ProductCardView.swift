//
//  ProductCardView.swift
//  ShoeShop
//
//  Created by Anand Yadav on 18/02/25.
//

import SwiftUI

struct ProductCardView: View {
    var product: Product
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottom) {
                Image(product.image)
                    .resizable()
                    .cornerRadius(20)
                    .frame(width: 180)
                    .scaledToFit()
                VStack(alignment: .leading) {
                    Text(product.name).bold()
                    Text("$\(product.price)")
                        .font(.caption)
                }
                .padding()
                .frame(width: 180, alignment: .leading)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
            }
            .clipped()
            .frame(width: 180, height: 250)
            .shadow(radius: 10)
            
            Button {
                cartManager.addToCart(product: product)
            } label: {
                Image(systemName: "plus")
                    .background(.thickMaterial)
                    .cornerRadius(30)
                    .font(.title3).bold()
                    .clipped()
                    .shadow(radius: 3)
                    .padding(10)
            }
        }
    }
}

#Preview {
    ProductCardView(product: Product.productList[3])
        .environmentObject(CartManager())
}
