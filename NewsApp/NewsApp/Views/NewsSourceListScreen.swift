//
//  NewsSourceListScreen.swift
//  NewsApp
//
//  Created by Anand Yadav on 07/03/25.
//

import SwiftUI

struct NewsSourceListScreen: View {
    let sourcrID:String
    @StateObject var viewModel = NewsSourceListViewModel(webService: Webservice())

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
                    List(viewModel.newsArticles) { article in
                        ExtractedView(article: article)
                    }
                }
            }
            .navigationTitle(sourcrID.uppercased())
            .task {
                await viewModel.fetchNewsSourceData(sourceID: sourcrID)
            }
        }
    }
}

#Preview {
    NewsSourceListScreen(sourcrID: "5")
}

struct ExtractedView: View {
    let article: NewsArticle

    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: article.urlToImage!)) { image in
                image.resizable()
                    .frame(maxWidth: 150, maxHeight: 150)
            } placeholder: {
                ProgressView("Loading...")
                    .frame(maxWidth: 150, maxHeight: 150)
            }
            VStack {
                Text(article.title)
                    .font(.headline)
                Text(article.description).font(.subheadline)
            }
        }
    }
}
