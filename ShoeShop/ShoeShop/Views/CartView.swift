//
//  CartView.swift
//  ShoeShop
//
//  Created by Anand Yadav on 21/02/25.
//

import SwiftUI

struct CartView:View {
    @EnvironmentObject var cartManager:CartManager
    var body: some View {
        VStack {
            if cartManager.count > 0 {
                ForEach(cartManager.items) { item in
                    ProductRow(cartItem: item)
                        .environmentObject(cartManager)
                }
                Divider()
                HStack {
                    Text("Cart total is:")
                    Spacer()
                    Text("$\(cartManager.total)").bold()
                }.padding()
            } else {
                VStack {
                    Image(systemName: "cart")
                        .font(.largeTitle)
                        .padding()
                        .overlay(Circle().stroke())
                    Text("Cart is empty.")
                }
                .foregroundStyle(.cyan)
            }
        }
        Spacer()
        .onAppear {
            print(cartManager.items)
        }
       
    }
}

#Preview {
    ContentView()
//    CartView()
//        .environmentObject(CartManager())
}

