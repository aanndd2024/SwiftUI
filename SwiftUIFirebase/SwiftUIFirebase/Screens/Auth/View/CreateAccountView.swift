//
//  CreateAccountView.swift
//  SwiftUIFirebase
//
//  Created by Anand Yadav on 26/11/24.
//
import SwiftUI

struct CreateAccountView:View {
    @State private var email:String = ""
    @State private var fullName:String = ""
    @State private var password:String = ""
    @State private var confirmPassword:String = ""
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Please complete all information to create an account")
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundStyle(.gray)
            Spacer().frame(height: 15)
            InputView(placeholderText: "Email or Phone Number", text: $email)
            InputView(placeholderText: "Full Name", text: $fullName)
            InputView(placeholderText: "Password", text: $password, isSecureField: true)
            ZStack(alignment: .trailing) {
                InputView(placeholderText: "Confirm Password", text: $confirmPassword, isSecureField: true)

                Spacer()
                if !password.isEmpty && !confirmPassword.isEmpty {
                    Image(systemName: "\(isValidPassword ? "checkmark.circle.fill" : "xmark.circle.fill")")
                        .imageScale(.large)
                        .foregroundStyle(isValidPassword ? .green : .red)
                }
            }

            Spacer()

            createAccountButton
        }
        .padding()
        .toolbarRole(.editor)
        .navigationTitle("Setup your account")
    }
    
    var isValidPassword: Bool {
        password == confirmPassword
    }
    
    private var createAccountButton: some View {
        Button {
            Task {
                await viewModel.createUser(email: email, fullName: fullName, password: password)
            }
        } label: {
            Text("Create Account")
        }.buttonStyle(CapsuleButtonStyle(bgColor: .teal, textColor: .white, hasBorder: false))
    }
}

#Preview {
    CreateAccountView()
}

