//
//  CocktailViewModel.swift
//  CocktailBook
//
//  Created by Anand Yadav on 13/02/25.
//

import Foundation


@MainActor
class CocktailListViewModel: ObservableObject {
    @Published var cocktails: [Cocktail] = []
    @Published var selectedFilter: FilterOption = .all
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    enum FilterOption: String, CaseIterable {
        case all = "All"
        case alcoholic = "Alcoholic"
        case nonAlcoholic = "Non-Alcoholic"
        
        func matches(_ cocktail: Cocktail) -> Bool {
            switch self {
            case .all: return true
            case .alcoholic: return cocktail.type == "alcoholic"
            case .nonAlcoholic: return cocktail.type == "non-alcoholic"
            }
        }
    }
    
    var filteredCocktails: [Cocktail] {
        cocktails.filter { selectedFilter.matches($0) }
    }
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchCocktails() async {
        isLoading = true
        errorMessage = nil
        
        do {
            self.cocktails = try await self.networkManager.fetchCocktails()
            print("✅ Successfully fetched \(cocktails.count) cocktails.")
        } catch {
            errorMessage = error.localizedDescription
            print("❌ Error fetching cocktails: \(errorMessage!)")
        }
        
        isLoading = false
    }
    
    func setFavorite(for cocktail: Cocktail) {
            if let index = cocktails.firstIndex(where: { $0.id == cocktail.id }) {
                cocktails[index].isFavorite.toggle()
            }
        }
}
