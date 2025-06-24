//
//  CoinViewModelTest.swift
//  CryptoCoinTests
//
//  Created by Anand Yadav on 22/06/25.
//

import XCTest
@testable import CryptoCoin

@MainActor
final class CoinViewModelTest: XCTestCase {

    func testLoadCoins_Success() async {
        // Arrange
        let viewModel = CoinViewModel(service: MockCoinServiceSuccess())
        
        // Act
        await viewModel.fetchCoins()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.coins.count, 2)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testLoadCoins_Failure() async {
        // Arrange
        let viewModel = CoinViewModel(service: MockCoinServiceFailure())
        
        // Act
        await viewModel.fetchCoins()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.coins.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
}
