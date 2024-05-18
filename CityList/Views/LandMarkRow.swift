//
//  LandMarkRow.swift
//  CityList
//
//  Created by Anand Yadav on 18-05-2024.
//

import SwiftUI

struct LandMarkRow: View {
    var landmark:Landmark
    var body: some View {
        HStack {
            Image(landmark.photo!)
                .resizable()
                //.scaledToFit()
                .frame(width: 120, height: 100, alignment: .center)
            VStack(alignment:.leading ) {
                Text(landmark.name!).font(.title2)
                    .padding(.bottom,5)
                Text(landmark.description!).lineLimit(4).font(.subheadline)
            }.padding(.leading,5)
        }
    }
}

#Preview {
    LandMarkRow(landmark: Landmark(landmarkID: 123, name: "Taj Mahal", photo: "TajMahal", description: "The Taj Mahal, located in Agra, India, is one of the most iconic and beautiful structures in the world. It is renowned for its stunning architecture, intricate details, and historical significance."))
}
