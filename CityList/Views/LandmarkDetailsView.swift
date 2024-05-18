//
//  LandmarkDetailsView.swift
//  CityList
//
//  Created by Anand Yadav on 19-05-2024.
//

import SwiftUI

struct LandmarkDetailsView: View {
    var landmark:Landmark
    var body: some View {
        VStack(alignment:.leading, spacing: 20 ){
            Image(landmark.photo!)
                .resizable()
                .scaledToFit()
            Text(landmark.description!)
            Spacer()
        }.padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(landmark.name!)
    }
}

#Preview {
    LandmarkDetailsView(landmark: Landmark(landmarkID: 123, name: "Taj Mahal", photo: "TajMahal", description: "The Taj Mahal, located in Agra, India, is one of the most iconic and beautiful structures in the world. It is renowned for its stunning architecture, intricate details, and historical significance."))
}
