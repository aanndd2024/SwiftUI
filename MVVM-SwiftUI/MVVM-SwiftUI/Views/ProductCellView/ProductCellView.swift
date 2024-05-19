//
//  ProductCellView.swift
//  MVVM-SwiftUI
//
//  Created by Anand Yadav on 19-05-2024.
//

import SwiftUI

struct ProductCellView: View {
    let product: Product
    var body: some View {
        HStack(spacing: 8) {
            if let imageURL = URL(string: product.image) {
                getProductImage(url: imageURL)
            }
            VStack(alignment:.leading, spacing: 8)  {
                Text(product.title).font(.headline).lineLimit(2)
                HStack {
                    Text(product.category).font(.subheadline).foregroundColor(Color.secondary)
                    Spacer()
                    HStack {
                        Image(systemName: "star.fill")
                        Text("\(product.rating.rate.toString())")
                            .fontWeight(.medium)
                    }.foregroundColor(.yellow)
                }
                Text(product.description)
                    .font(.footnote)
                    .lineLimit(3)
                HStack {
                    Text(product.price.currencyFormat()).font(.title3).foregroundColor(.indigo)
                    Spacer()
                    buyButton
                }
            }
        }.padding() //Default padding is 16.0
    }
    
    func getProductImage(url:URL) -> some View {
        AsyncImage(url: url) { image in
            image.resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 100, height: 100)
    }
    
    var buyButton: some View {
        Button {
        } label: {
            Text("Buy")
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .foregroundColor(.white)
        .background(.indigo)
        .clipShape(.capsule)
    }
}

#Preview {
    ProductCellView(product: Product.dummy)
}
