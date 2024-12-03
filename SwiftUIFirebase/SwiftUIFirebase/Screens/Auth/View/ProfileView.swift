//
//  ProfileView.swift
//  SwiftUIFirebase
//
//  Created by Anand Yadav on 27/11/24.
//
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var router: Router

    var body: some View {
        if viewModel.isLoading {
            ProgressView("Logging...")
        }
        if let currentUser = viewModel.currentUser {
            List {
                Section {
                    HStack (spacing: 10){
                        Text(currentUser.initials)
                            .fontWeight(.semibold)
                            .font(.title)
                            .frame(width: 70, height: 70)
                            .background(Color(.lightGray))
                            .foregroundStyle(.white)
                            .clipShape(.circle)
                        VStack (alignment: .leading, spacing: 5){
                            Text(currentUser.fullName)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text(currentUser.email)
                                .font(.subheadline)
                        }
                    }
                }
                Section("General") {
                    Button {
                        viewModel.signOut()
                    } label: {
                        Label {
                            Text("Sign Out")

                        } icon: {
                            Image(systemName: "arrow.left.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    Button {
                        Task {
                            await viewModel.deleteAccount()
                        }
                    } label: {
                        Label {
                            Text("Delete Account")

                        } icon: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
