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
                ProductCellView(product: product)
            }.navigationTitle("Product")
                .listStyle(.plain)
        }.task {
            await viewModel.fetchProducts()
        }
    }
}

#Preview {
    ProductListView()
}
 
