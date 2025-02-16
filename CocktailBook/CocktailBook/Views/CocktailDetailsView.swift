//
//  CocktailDetailsView.swift
//  CocktailBook
//
//  Created by Anand Yadav on 13/02/25.
//
import SwiftUI

struct CocktailDetailView: View {
    let cocktail: Cocktail

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Image(systemName: "clock")
                    Text("\(cocktail.preparationMinutes) minutes")
                }
                Image(cocktail.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                Text(cocktail.name)
                    .font(.title3)
                    .bold()

                Text(cocktail.longDescription)
                    .font(.body)
                    .padding(.top, 5)

                Text("Ingredients")
                    .font(.title2)
                    .bold()
                    .padding(.top, 10)

                ForEach(cocktail.ingredients, id: \.self) { ingredient in
                    Text("• \(ingredient)")
                        .font(.body)
                }
            }
            .padding()
        }
        .navigationTitle("Cocktail Details")
    }
}
