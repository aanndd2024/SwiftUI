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
    
    private let auth = Auth.auth()
    private let fireStore = Firestore.firestore()
    
    init() {}
    
    func createUser(email:String, fullName:String, password:String) async {
        do{
            //Adding User in Auth
            let authResult = try await auth.createUser(withEmail: email, password: password)
            
            //Adding User Details in Database FireStore
            await storeuserInFireStore(uid: authResult.user.uid, email: email, fullname: fullName)
        } catch {
            errorMessage = error.localizedDescription
            isError = true
        }
    }
    
    func storeuserInFireStore(uid:String, email:String, fullname:String) async {
        let user = User(uid: uid, email: email, fullName: fullname)
        do {
            try fireStore.collection("users").document(uid).setData(from: user)
        } catch {
            
        }
    }
}
