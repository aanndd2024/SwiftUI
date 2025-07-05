//
//  CoinDetails.swift
//  CryptoCoin
//
//  Created by Anand Yadav on 24/06/25.
//

struct CoinDetails: Codable {
    let id: String
    let name: String
    let symbol: String
    let description: Description
    let image: Image
    let market_data: MarketData

    struct Description: Codable {
        let en: String
    }

    struct Image: Codable {
        let large: String
    }

    struct MarketData: Codable {
        let current_price: [String: Double]
        let price_change_percentage_24h: Double
        let market_cap: [String: Double]
    }
}

