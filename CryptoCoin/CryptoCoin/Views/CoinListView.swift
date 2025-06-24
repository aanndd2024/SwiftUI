//
//  CoinListView.swift
//  CryptoCoin
//
//  Created by Anand Yadav on 21/06/25.
//

import SwiftUI

struct CoinListView: View {
    @StateObject private var viewModel = CoinViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                content
                    .navigationTitle("Top Coins")
            }
            .onAppear {
                if viewModel.coins.isEmpty {
                    Task {
                        await viewModel.fetchCoins()
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView("Loading...")
        } else if let error = viewModel.errorMessage {
            Text(error).foregroundColor(.red)
                .padding()
        } else {
            coinList
        }
    }
    
    private var coinList: some View {
        List(viewModel.coins) { coin in
            NavigationLink(value: coin) {
                CoinRowView(coin: coin)
            }
        }
        .navigationDestination(for: Coin.self) { coin in
            CoinDetailsView(coin: coin)
        }
        .refreshable {
            await viewModel.fetchCoins()
        }
        .onAppear {
            //print(viewModel.coins)
        }
    }
}
