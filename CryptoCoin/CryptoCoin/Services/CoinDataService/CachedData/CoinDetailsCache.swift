//
//  CoinDetailsCache.swift
//  CryptoCoin
//
//  Created by Anand Yadav on 26/06/25.
//

import Foundation


final class CoinDetailsCache {
    static let shared = CoinDetailsCache()
    private init() {}
    private let cache = NSCache<NSString, NSData>()
    
    func get(for key: String) -> CoinDetails? {
        guard let data = cache.object(forKey: key as NSString) else { return nil }
        
        do {
            let decoded = try JSONDecoder().decode(CoinDetails.self, from: data as Data)
            return decoded
        } catch {
            print("❌ Cache decode failed: \(error)")
            return nil
        }
    }
    
    func set(_ value: CoinDetails, for key: String) {
        do {
            let encoded = try JSONEncoder().encode(value)
            cache.setObject(encoded as NSData, forKey: key as NSString)
        } catch {
            print("❌ Cache encode failed: \(error)")
        }
    }
}
