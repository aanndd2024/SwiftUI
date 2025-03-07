//
//  NewsListView.swift
//  NewsApp
//
//  Created by Anand Yadav on 07/03/25.
//

import SwiftUI

struct NewsListView: View {
    @StateObject var viewModel = NewsListViewModel(webService: Webservice())
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    VStack {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5) // Make it bigger
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white.opacity(0.8)) // Slightly dim background
                } else if let error = viewModel.error {
                    VStack {
                        Text("Failed to load data")
                            .font(.headline)
                            .foregroundColor(.red)
                        Text(error.localizedDescription)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                } else {
                    List(viewModel.newsSourceData) { source in
                        NavigationLink(destination: NewsSourceListScreen(sourcrID: source.id)) {
                            VStack(alignment: .leading) {
                                Text(source.name)
                                    .font(.headline)
                                Text(source.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("")
            .task {
                await viewModel.fetchNewsSourceData()
            }
        }
    }
}

#Preview {
    NewsListView()
}
