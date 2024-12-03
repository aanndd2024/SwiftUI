//
//  Router.swift
//  SwiftUIFirebase
//
//  Created by Anand Yadav on 02/12/24.
//
import SwiftUI

final class Router: ObservableObject {
    enum AuthFlow: Codable, Hashable {
        case login
        case createAccount
        case profile
        case forgotPassword
        case emailSent
    }
    @Published var navPath = NavigationPath()
    
    func navigate(to destination:AuthFlow) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}

