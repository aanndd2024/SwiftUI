//
//  Coins.swift
//  CryptoCoin
//
//  Created by Anand Yadav on 21/06/25.
//

struct Coin: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let symbol: String
    let image: String
    let current_price: Double
    let price_change_percentage_24h: Double
}
