//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by Anand Yadav on 18/06/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("Screens")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Hello America")
                    .foregroundStyle(.white)
                    .padding(.top, 20)
                    Spacer()
                
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}
