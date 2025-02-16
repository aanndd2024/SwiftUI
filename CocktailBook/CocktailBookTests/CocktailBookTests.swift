//
//  CocktailBookTests.swift
//  CocktailBookTests
//
//  Created by Anand Yadav on 16/02/25.
//

import Testing
@testable import CocktailBook

@Suite
struct CocktailBookTests {
    
    @MainActor
    private func makeViewModel() async -> CocktailListViewModel {
        let viewModel = CocktailListViewModel(networkManager: MockNetworkManager(shouldSucceed: true))
        // Wait for fetchCocktails to complete
        await viewModel.fetchCocktails()
        return viewModel
    }
    
    @MainActor
    @Test("All Cocktails")
    func test_FilterALL_shouldReturnAllCocktails() async {
        let viewModel = await makeViewModel()
        viewModel.selectedFilter = .all
        let allCocktails = viewModel.filteredCocktails
        #expect(allCocktails.count == 4)
    }
    
    @MainActor
    @Test("Alcoholic Cocktails")
    func test_FilterAlcoholic_shouldReturnAlcoholicCocktails() async {
        let viewModel = await makeViewModel()
        viewModel.selectedFilter = .alcoholic
        let allCocktails = viewModel.filteredCocktails
        #expect(allCocktails.count == 3)
    }
    
    @MainActor
    @Test("Non-Alcoholic Cocktails")
    func test_FilterNonAlcoholic_shouldReturnNonAlcoholicCocktails() async {
        let viewModel = await makeViewModel()
        viewModel.selectedFilter = .nonAlcoholic
        let allCocktails = viewModel.filteredCocktails
        #expect(allCocktails.count == 1)
    }
}
