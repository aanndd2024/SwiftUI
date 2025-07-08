//
//  ContentView.swift
//  EnvironmentConfig
//
//  Created by Anand Yadav on 07/07/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            print("Environment:", ConfigManager.environment)
            print("Base URL:", ConfigManager.baseURL)
            print("Logging Enabled:", ConfigManager.isLoggingEnabled)
        }
    }
}

#Preview {
    ContentView()
}
