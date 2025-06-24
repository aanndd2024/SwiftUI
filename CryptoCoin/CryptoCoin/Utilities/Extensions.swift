//
//  Extensions.swift
//  CryptoCoin
//
//  Created by Anand Yadav on 21/06/25.
//

import Foundation

extension CoinError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid API URL"
        case .invalidResponse:
            return "Invalid server response"
        case .decodingError(let error):
            return "Failed to decode data: \(error.localizedDescription)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .invalidData:
            return "Invalid Data response"
        }
    }
}
