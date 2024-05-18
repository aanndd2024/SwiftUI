//
//  LandMark.swift
//  CityList
//
//  Created by Anand Yadav on 16-05-2024.
//

import Foundation

struct City: Codable {
    var cityID: Int?
    var name: String?
    var landmarks: [Landmark]?

    enum CodingKeys: String, CodingKey {
        case cityID = "cityId"
        case name, landmarks
    }
}

// MARK: - Landmark
struct Landmark: Codable {
    var landmarkID: Int?
    var name, photo, description: String?

    enum CodingKeys: String, CodingKey {
        case landmarkID = "landmarkId"
        case name, photo, description
    }
}
 
