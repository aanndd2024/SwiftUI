//
//  CoinDetailsView.swift
//  CryptoCoin
//
//  Created by Anand Yadav on 24/06/25.
//

import SwiftUI

struct CoinDetailsView: View {
    @StateObject private var viewModel: CoinDetailsViewModel

    init(coin: Coin) {
        _viewModel = StateObject(wrappedValue: CoinDetailsViewModel(coinID: coin.id))
    }

    var body: some View {
        ScrollView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .backgroundStyle(.red)
                } else if let coinsDetails = viewModel.coinsDetails {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text(coinsDetails.name)
                                .font(.largeTitle)
                                .bold()
                            Spacer()
                            if let imageURL = URL(string: coinsDetails.image.large) {
                                AsyncImage(url: imageURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                        .shadow(radius: 5)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        
                        Text("Symbol: \(coinsDetails.symbol.uppercased())").bold()
                        Text("Description: \(coinsDetails.description)")
                    }
                    .padding()
                } else {
                    Text("No data available.")
                }
                Spacer()
            }
        }
        // Added .task modifier - To handle quick navigation between views while preventing unnecessary API calls when quickly navigating back
        .task {
            await viewModel.fetchCoinDetails()
        }
//        .onAppear {
//            Task {
//                await viewModel.fetchCoinDetails()
//            }
//        }
        .navigationTitle("Coin Details")
    }
}
