//
//  AuthViewModel.swift
//  SwiftUIFirebase
//
//  Created by Anand Yadav on 26/11/24.
//

import Combine
import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
final class AuthViewModel:ObservableObject {
    @Published var userSession:FirebaseAuth.User?
    @Published var currentUser:User?
    @Published var isError:Bool = false
    @Published var errorMessage:String = ""
    @Published var isLoading:Bool = false
    private let auth = Auth.auth()
    private let fireStore = Firestore.firestore()
    
    init() {}
    
    func createUser(email:String, fullName:String, password:String) async {
        do{
            isLoading = true
            //Adding User in Auth
            let authResult = try await auth.createUser(withEmail: email, password: password)
            
            //Adding User Details in Database FireStore
            await storeuserInFireStore(uid: authResult.user.uid, email: email, fullname: fullName)
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            print(errorMessage)
            isError = true
            isLoading = false
        }
    }
    
    func login(email:String, password:String) async {
        do {
            isLoading = true

            let authResult = try await auth.signIn(withEmail: email, password: password)
            userSession = authResult.user
            print(authResult.user)
            await fetchUser(userID: authResult.user.uid)
            isLoading = false

        } catch {
            errorMessage = error.localizedDescription
            print(errorMessage)
            isError = true
            isLoading = false

        }
    }
    
    func storeuserInFireStore(uid:String, email:String, fullname:String) async {
        let user = User(uid: uid, email: email, fullName: fullname)
        do {
            isLoading = true

            try fireStore.collection("users").document(uid).setData(from: user)
        } catch {
            errorMessage = error.localizedDescription
            print(errorMessage)
            isError = true
            isLoading = false

        }
    }
    
    func fetchUser(userID:String) async {
        do {
            isLoading = true

            let userData = try await fireStore.collection("users").document(userID).getDocument()
            currentUser = try userData.data(as: User.self)
            print(currentUser?.fullName)
            isLoading = false

        } catch {
            errorMessage = error.localizedDescription
            print(errorMessage)
            isError = true
            isLoading = false

        }
    }
    
    func signOut() {
        do {
            isLoading = true

            userSession = nil
            currentUser = nil
            try auth.signOut()
            isLoading = false

        } catch {
            errorMessage = error.localizedDescription
            print(errorMessage)
            isError = true
            isLoading = false

        }
    }
    
    func deleteAccount() async {
        do {
            isLoading = true

            userSession = nil
            currentUser = nil
            deleteUser(by: auth.currentUser?.uid ?? "") // First delete from FireStore
            try await auth.currentUser?.delete() // Then delete fron Auth
            isLoading = false

        } catch {
            errorMessage = error.localizedDescription
            print(errorMessage)
            isError = true
            isLoading = false

        }
    }
    
    private func deleteUser(by uid:String) {
        fireStore.collection("users").document(uid).delete()
    }
    
    func resetPassword(by email:String) async {
        do {
            isLoading = true
            try await auth.sendPasswordReset(withEmail: email)
        } catch {
            errorMessage = error.localizedDescription
            print(errorMessage)
            isError = true
            isLoading = false
        }
    }
}
