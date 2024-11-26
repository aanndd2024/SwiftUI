//
//  ContentView.swift
//  SwiftUIFirebase
//
//  Created by Anand Yadav on 20/10/24.
//

import SwiftUI

struct LoginView: View {
    @State var username:String = ""
    @State var password:String = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) {
                    logo
                    Spacer().frame(height: 12)
                    title
                    Spacer().frame(height: 10)
                    
                    InputView(placeholderText: "Email or Mobile Number", text: $username)
                    Spacer().frame(height: 10)
                    
                    InputView(placeholderText: "Password", text: $password, isSecureField: true)
                    
                    forgotPasswordButton
                    Spacer().frame(height: 10)
                    
                    loginButton
                    
                    bottomView
                }
            }
            .ignoresSafeArea()
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
    private var logo: some View {
        Image(.login)
            .resizable()
            .scaledToFit()
    }
    
    private var title: some View {
        Text("Let's Connect With US!")
            .font(.title2)
            .fontWeight(.semibold)
    }
    
    private var forgotPasswordButton: some View {
        HStack {
            Spacer()
            Button {
                
            } label: {
                Text("Forgot Password")
                    .foregroundStyle(.gray)
            }
        }
    }
    
    private var loginButton: some View {
        Button {
            
        } label: {
            Text("Login")
        }.buttonStyle(CapsuleButtonStyle(bgColor: .teal, textColor: .white, hasBorder: false))
    }
    
    private var orView: some View {
        HStack {
            VStack {
                Divider()
            }
            Text("Or")
            VStack {
                Divider()
            }
        }
    }
    
    private var appleButton: some View {
        Button {
            
        } label: {
            Label("Sign up with Apple", systemImage: "apple.logo")
        }.buttonStyle(CapsuleButtonStyle(bgColor: .black, textColor: .white, hasBorder: false))
    }
    
    private var googleButton: some View {
        Button {
            
        } label: {
            HStack {
                Image(.google)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                Text("Sign up with Google")
            }
        }.buttonStyle(CapsuleButtonStyle(bgColor: .clear, textColor: .black, hasBorder: true))
    }
    
    private var signUpButton: some View {
        NavigationLink {
            CreateAccountView()
        } label: {
            HStack {
                Text("Don't have an account?").foregroundStyle(.black)
                Text("Sign Up").foregroundStyle(.teal)
                    .fontWeight(.medium)
            }.padding(.top, 10)
        }
    }
    
    private var bottomView: some View {
        VStack(spacing: 16) {
            orView
            appleButton
            googleButton
            signUpButton
        }
    }
}

#Preview {
    LoginView()
}

struct InputView: View {
    var placeholderText:String
    @Binding var text: String
    var isSecureField: Bool = false
    var body: some View {
        VStack(spacing: 6) {
            if isSecureField {
                SecureField(placeholderText, text: $text)
            } else {
                TextField(placeholderText, text: $text)
            }
            Divider()
        }
    }
}

//ViewModifier
struct CapsuleButtonStyle: ButtonStyle {
    var bgColor:Color
    var textColor:Color
    var hasBorder:Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(textColor)
            .fontWeight(.medium)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Capsule().fill(bgColor))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .overlay {
                hasBorder ? Capsule().stroke(.gray, lineWidth: 1) : nil
            }
    }
}
