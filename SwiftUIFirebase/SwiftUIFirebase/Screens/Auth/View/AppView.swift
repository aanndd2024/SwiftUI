//
//  AppView.swift
//  SwiftUIFirebase
//
//  Created by Anand Yadav on 29/11/24.
//
import SwiftUI
import Combine

struct AppView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.userSession == nil {
                LoginView()
            }else {
                ProfileView()
            }
        }
        .environmentObject(authViewModel)
    }
}

#Preview {
    AppView()
}
