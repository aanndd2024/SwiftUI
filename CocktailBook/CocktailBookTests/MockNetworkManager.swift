//
//  MockNetworkManager.swift
//  CocktailBook
//
//  Created by Anand Yadav on 16/02/25.
//

@testable import CocktailBook

class MockNetworkManager: NetworkManagerProtocol {
    private let shouldSucceed: Bool
    private let mockCocktails: [Cocktail]

    init(shouldSucceed: Bool = true, mockCocktails: [Cocktail]? = nil) {
            self.shouldSucceed = shouldSucceed
            self.mockCocktails = mockCocktails ?? [
                Cocktail(id: "1", name: "Mojito", type: "alcoholic", shortDescription: "Minty cocktail", longDescription: "A Cuban classic...", preparationMinutes: 5, imageName: "mojito", ingredients: [], isFavorite: false),
                Cocktail(id: "2", name: "Old Fashioned", type: "alcoholic", shortDescription: "Whiskey cocktail", longDescription: "A bourbon-based drink...", preparationMinutes: 5, imageName: "oldfashioned", ingredients: [], isFavorite: false),
                Cocktail(id: "3", name: "Virgin Mojito", type: "non-alcoholic", shortDescription: "Non-alcoholic minty cocktail", longDescription: "A refreshing alternative...", preparationMinutes: 5, imageName: "virginmojito", ingredients: [], isFavorite: false),
                Cocktail(id: "4", name: "Margarita", type: "alcoholic", shortDescription: "Tequila-based cocktail", longDescription: "A classic lime-flavored drink...", preparationMinutes: 5, imageName: "margarita", ingredients: [], isFavorite: false)
            ]
        }
    
    func fetchCocktails() async throws -> [Cocktail] {
        if shouldSucceed {
            return mockCocktails
        }
        throw NetworkError.decodingError
    }
}
