//
//  StoreViewModel.swift
//  MVVM-SwiftUI
//
//  Created by Anand Yadav on 19-05-2024.
//

import Foundation

//class ProductViewModel:ObservableObject {
//    @Published var products: [Product] = []
//    private let manager = APIManager()
//    
//    func fetchProducts() async {
//        do {
//            products = try await manager.request(url: "https://fakestoreapi.com/products")
//            print(products)
//        }catch {
//            print("Fetch Product error:", error)
//        }
//    }
//}


//Available onwards Xcode 15, No need to mention @published and @State in calling class
@Observable class ProductViewModel {
    
    var products: [Product] = []
    private let manager = APIManager()
    
    func fetchProducts() async {
        do {
            products = try await manager.request(url: "https://fakestoreapi.com/products")
            print(products)
        }catch {
            print("Fetch Product error:", error)
        }
    }
}
