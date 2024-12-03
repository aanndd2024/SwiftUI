//
//  SwiftUIFirebaseApp.swift
//  SwiftUIFirebase
//
//  Created by Anand Yadav on 20/10/24.
//

import SwiftUI
import UIKit
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct SwiftUIFirebaseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authViewModel = AuthViewModel()
    @ObservedObject private var router = Router()
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                AppView()
                    .navigationDestination(for: Router.AuthFlow.self) { destination in
                        switch destination {
                        case .createAccount: CreateAccountView()
                        case .login: LoginView()
                        case .forgotPassword: ForgotPasswordView()
                        case .emailSent: EmailSentView()
                        case .profile: ProfileView()
                        }
                    }
            }
            .environmentObject(router)
            .environmentObject(authViewModel)
        }
    }
}
