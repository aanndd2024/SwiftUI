//
//  CocktailListView.swift
//  CocktailBook
//
//  Created by Anand Yadav on 13/02/25.
//
import SwiftUI

struct CocktailListView: View {
    @StateObject private var viewModel = CocktailListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                segmentFilterView
                    .padding()
                
                cocktailListView
                    .listStyle(PlainListStyle())
                    .scrollContentBackground(.hidden)
            }
            .navigationTitle(viewModel.selectedFilter.rawValue)
            .task {
                await viewModel.fetchCocktails()
            }
        }
    }
    
    private var segmentFilterView: some View {
        Picker("Filter", selection: $viewModel.selectedFilter) {
            ForEach(CocktailListViewModel.FilterOption.allCases, id: \.self) { filter in
                Text(filter.rawValue).tag(filter)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    private var cocktailListView:some View {
        List(viewModel.filteredCocktails) { cocktail in
            NavigationLink(destination: CocktailDetailView(cocktail: cocktail)) {
                VStack(alignment: .leading) {
                    HStack {
                        Text(cocktail.name)
                            .font(.headline)
                            .foregroundStyle(cocktail.isFavorite ? .purple : .black)
                        Spacer()
                        Button(action: {
                            viewModel.setFavorite(for: cocktail)
                        }) {
                            Image(systemName: cocktail.isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(cocktail.isFavorite ? .purple : .gray)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    Text(cocktail.shortDescription)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

#Preview {
    CocktailListView()
}
