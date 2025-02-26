//
//  ProductListView.swift
//  ShoeShop
//
//  Created by Anand Yadav on 18/02/25.
//

import SwiftUI

struct ProductListView: View {
    @StateObject var cartManager = CartManager()
    
    var column = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var cartButtonView: some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "cart")
                .padding(.top, 10)
                .font(.title3)
            if cartManager.count > 0 {
                Text("\(cartManager.count)")
                    .font(.caption2.bold())
                    .foregroundColor(.white)
                    .frame(width: 15, height: 15)
                    .background(Color.pink)
                    .cornerRadius(20)
            }
        }
    }
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: column, spacing: 20) {
                    ForEach(Product.productList) { product in
                        NavigationLink(destination: ProductDetailsView(product: product)
                            .environmentObject(cartManager)) {
                                ProductCardView(product: product)
                                    .environmentObject(cartManager)
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Product List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink {
                    CartView()
                        .environmentObject(cartManager)
                } label: {
                    cartButtonView
                }
            }
        }
    }
}

#Preview {
    ProductListView()
}
