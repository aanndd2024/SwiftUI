//
//  ContentView.swift
//  MVVM-SwiftUI
//
//  Created by Anand Yadav on 19-05-2024.
//

import SwiftUI

struct ProductListView: View {
    //@StateObject var viewModel = ProductViewModel()
    let viewModel = ProductViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.products) { product in
                NavigationLink{
                    ProductDetailsView(product: product)
                } label: {
                    ProductCellView(product: product)
                }
            }
            .navigationTitle("Products")
            .listStyle(.plain)
        }.task {
            await viewModel.fetchProducts()
        }
    }
}

#Preview {
    ProductListView()
}
 
