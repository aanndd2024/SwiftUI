//
//  CityModel.swift
//  CityList
//
//  Created by Anand Yadav on 17-05-2024.
//

import Foundation

//struct CityViewModel {
//    
//    var cityList: [City] = []
//    
//    mutating func getCityList() {
//        let landmarkJson = Bundle.main.path(forResource: "CityLandmark", ofType: "json")
//        let landmark = try! Data(contentsOf: URL(fileURLWithPath: landmarkJson!), options: .alwaysMapped)
//        cityList =  try! JSONDecoder().decode([City].self, from: landmark)
//    }
//}

struct CityViewModel {
    static func decodeLandmarkBundleJson() -> [City] {
        let landmarkJson = Bundle.main.path(forResource: "CityLandmark", ofType: "json")
        let landmark = try! Data(contentsOf: URL(fileURLWithPath: landmarkJson!), options: .alwaysMapped)
        return try! JSONDecoder().decode([City].self, from: landmark)
    }
}
