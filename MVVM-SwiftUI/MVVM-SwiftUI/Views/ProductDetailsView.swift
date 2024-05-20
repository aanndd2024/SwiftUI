//
//  ProductDetailsView.swift
//  MVVM-SwiftUI
//
//  Created by Anand Yadav on 20-05-2024.
//

import SwiftUI

struct ProductDetailsView: View {
    let product: Product
    var body: some View {
        VStack(spacing: 10){
            AsyncImageView(imageURL: product.image)
                .scaledToFit()
                .frame(height: 300)
            Text(product.title).font(.headline)
            Text(product.description).font(.footnote)
            RatingSubView(rate: product.rating)
            
            Spacer()
        }.padding()
        HStack{
            VStack {
                Text("Total Price").fontWeight(.medium)
                Text(product.price.currencyFormat())
                    .font(.title3).foregroundColor(.indigo)
            }.padding()
            Spacer()
            HStack {
                Image(systemName: "cart.fill.badge.plus")
                Text("Buy Now")
            }.padding()
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(.gray.opacity(0.2))
        .padding()
        
    }
}

#Preview {
    ProductDetailsView(product: Product.dummy)
}

struct RatingSubView: View {
    let rate:Rate
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "star.fill").foregroundColor(.yellow)
                Text("\(rate.rate.toString() + " " + "Rating")")
                    .fontWeight(.medium)
            }
            Spacer()
            circleImage
            Text("\(rate.count)" + " Reviews")
            Spacer()
            circleImage
            Text("4.6k Sold")
            
        }.foregroundColor(.secondary)
    }
    var circleImage:some View {
        Image(systemName: "circle.fill")
            .resizable()
            .frame(width: 8, height: 8)
    }
}
