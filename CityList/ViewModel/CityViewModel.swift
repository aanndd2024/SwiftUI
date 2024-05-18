//
//  CityModel.swift
//  CityList
//
//  Created by Anand Yadav on 17-05-2024.
//

import Foundation

class CityModel: ObservableObject {
    
    @Published var task: [City] = []
    
    func getCityList() -> [City] {
        let landmarkJson = Bundle.main.path(forResource: "CityLandmark", ofType: "json")
        let landmark = try! Data(contentsOf: URL(fileURLWithPath: landmarkJson!), options: .alwaysMapped)
        return try! JSONDecoder().decode([City].self, from: landmark)
    }
}
