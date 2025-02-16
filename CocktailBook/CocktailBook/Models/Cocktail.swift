//
//  Cocktail.swift
//  CocktailBook
//
//  Created by Anand Yadav on 13/02/25.
//

struct Cocktail: Identifiable, Decodable {
    let id: String
    let name: String
    let type: String
    let shortDescription: String
    let longDescription: String
    let preparationMinutes: Int
    let imageName: String
    let ingredients: [String]
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, name, type, shortDescription, longDescription, preparationMinutes, imageName, ingredients
    }
}
