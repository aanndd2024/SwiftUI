//
//  ForgotPasswordView.swift
//  SwiftUIFirebase
//
//  Created by Anand Yadav on 29/11/24.
//
import SwiftUI

struct ForgotPasswordView:View {
    @State private var email:String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var router: Router

    var body: some View {
        if viewModel.isLoading {
            ProgressView("Sending Email...")
        }
        VStack(spacing: 16) {
            VStack(alignment: .leading){
                Text("Reset Password")
                    .font(.title)
                Text("Enter the Email associated with your account and we'll send an Email with instruction to reset your password.")
                    .foregroundStyle(.secondary)
            }
           
            InputView(placeholderText: "Enter your Email", text: $email)
            Spacer().frame(height: 5)
            Button {
                Task {
                    await viewModel.resetPassword(by: email)
                    if !viewModel.isError {
                        router.navigate(to: .emailSent)
                    }
                }
            } label: {
                Text("Send Instruction")
            }.buttonStyle(CapsuleButtonStyle(bgColor: .teal, textColor: .white, hasBorder: false))
            Spacer()
        }
        .padding()
        .toolbarRole(.editor)
    }
}

#Preview {
    ForgotPasswordView()
}
