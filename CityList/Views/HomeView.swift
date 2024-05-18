//
//  HomeView.swift
//  CityList
//
//  Created by Anand Yadav on 17-05-2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
//            List(CityViewModel.decodeLandmarkBundleJson(), id: \.cityID) { city in
//                Section(city.name!) {
//                    ForEach(city.landmarks!, id:\.landmarkID) { landmark in
//                       LandMarkRow(landmark: landmark)
//                    }
//                }
//            }.navigationTitle("Landmark")
            List {
                ForEach(CityViewModel.decodeLandmarkBundleJson(), id: \.cityID) { city in
                    Section(city.name!) {
                        ForEach(city.landmarks!, id: \.landmarkID) { landmark in
                            NavigationLink(destination: LandmarkDetailsView(landmark: landmark)) {
                                LandMarkRow1(landmark: landmark)
                            }
                        }
                    }
                    
                }
            }.navigationTitle("Landmark")
        }
    }
}

#Preview {
    HomeView()
}


struct LandMarkRow1: View {
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



