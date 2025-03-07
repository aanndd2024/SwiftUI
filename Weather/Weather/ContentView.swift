//
//  ContentView.swift
//  Weather
//
//  Created by Anand Yadav on 24/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel(weatherService: WeatherService())
    @State var city: String = ""
    @State var isLoading: Bool = false // Add a loading state
    
    var body: some View {
        VStack {
            TextField("Enter Location: ", text: $city)
                .padding()
                .onSubmit {
                    Task {
                        isLoading = true // Start loading
                        await viewModel.fetchCoordinateByCity(city: city)
                        await viewModel.fetchWeather(location: viewModel.location!)
                        isLoading = false // Stop loading
                    }
                }
            
            if isLoading {
                ProgressView() // Show loading indicator
            } else {
                if let temp = viewModel.weather?.temp {
                    Text("\(temp)")
                } else {
                    Text("Enter a location to get weather data")
                }
            }
            
            Spacer()
        }
        .padding()
    }
}


struct progressView: View {
    @State private var progress: Double = 0.0
    var body: some View {
        VStack {
            ProgressView(value: progress, total: 100)
                .progressViewStyle(LinearProgressViewStyle())
                .padding()
            
            Button("Start Progress") {
                withAnimation {
                    progress = 100  // Animate to 100% over time
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
