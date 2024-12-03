//
//  EmailSentView.swift
//  SwiftUIFirebase
//
//  Created by Anand Yadav on 29/11/24.
//
import SwiftUI

struct EmailSentView:View {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var router: Router

    var body: some View {
        VStack (spacing: 20){
            Spacer()
            Image(systemName:"envelope.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(.teal)
            VStack {
                Text("Check your Email")
                    .font(.title.bold())
                Text("We have sent a password & recover password instruction to your mail")
                    .font(.subheadline.bold())
                    .foregroundStyle(.secondary)
            }
            skipButton
            Spacer()
            optionButton
        }
        .padding()
        .toolbarRole(.editor)
    }
    
    private var skipButton: some View {
        Button {
            router.navigateToRoot()
        } label: {
            Text("Skip, I'll confirm later")
        }.buttonStyle(CapsuleButtonStyle(bgColor: .teal, textColor: .white, hasBorder: false))
    }
    
    private var optionButton: some View {
        Button {
            router.navigateBack()
        } label: {
            Text("Did not receive the Email? Check your spam filter, or ").foregroundStyle(.black) + Text("try another Email address").foregroundStyle(.teal)
        }
    }
}


#Preview {
    EmailSentView()
}
