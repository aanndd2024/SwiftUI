//
//  ProductDetailsView.swift
//  ShoeShop
//
//  Created by Anand Yadav on 23/02/25.
//

import SwiftUI

struct ProductDetailsView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var averageColor:Color = .blue
    var product: Product
    
    private var cartButton: some View {
        NavigationLink {
            CartView()
                .environmentObject(cartManager)
        } label: {
            ZStack {
                Image(systemName: "cart")
                    .padding(.top, 5)
                if cartManager.count > 0 {
                    Text("\(cartManager.count)")
                }
            }
        }
    }
    
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
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(averageColor)
                VStack {
                    Image(product.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 180)
                        .cornerRadius(20)
                }
            }
            .edgesIgnoringSafeArea(.top)
            .frame(height: 300)
            HStack {
                Text(product.name)
                    .font(.title2)
                Spacer()
                Text("$\(product.price)").bold()
            }
            .padding()
            Text(product.desc)
                .font(.headline)
                .padding(.horizontal, 10)
            Spacer()
            Button {
                cartManager.addToCart(product: product)
            } label: {
                Text("Add to cart")
            }
            .font(.title2).bold()
            .foregroundStyle(.white)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(averageColor)
        }
        .onAppear {
            averageColor = Color(UIImage(named: product.image)?.averageColor() ?? .blue)
        }
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

#Preview {
    ProductDetailsView(product: Product.productList[2])
        .environmentObject(CartManager())
}
