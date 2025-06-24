//
//  CoinRowView.swift
//  CryptoCoin
//
//  Created by Anand Yadav on 24/06/25.
//

import SwiftUI

struct CoinRowView: View {
    let coin: Coin
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: coin.image)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 40, height: 40)
            .clipShape(.circle)
            
            VStack(alignment: .leading) {
                Text(coin.name)
                Text(coin.symbol)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(String(format: "$%.2f", coin.current_price))
                    .font(.body)
                Text(String(format: "%.2f%%", coin.price_change_percentage_24h))
                    .font(.caption)
                    .foregroundColor(coin.price_change_percentage_24h >= 0 ? .green : .red)
            }
        }
    }
}
