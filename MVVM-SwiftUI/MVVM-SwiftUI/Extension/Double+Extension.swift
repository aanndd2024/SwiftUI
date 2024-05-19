//
//  Double+Extension.swift
//  MVVM-SwiftUI
//
//  Created by Anand Yadav on 19-05-2024.
//

import Foundation
extension Double {
    func toString() -> String {
        return String(format: "%.1f",self)
    }
    func currencyFormat() -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
