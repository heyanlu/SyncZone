//
//  LoginViewModel.swift
//  SyncZone
//
//  Created by YL He on 7/1/24.
//
import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

//Function of login 
class OnBoardingViewModel: ObservableObject {
    @Published var onboardingState: String = "welcome"
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var checkPassword: String = ""
   
    
//    @Published var showLocationRequest: Bool = false
    
    @Published var alertMsg: String = ""
    @Published var showAlert: Bool = false
    
    @AppStorage("email") var currentEmail: String?
    @AppStorage("password") var currentPassword: String?
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
    @AppStorage("showLocationRequest") var showLocationRequest: Bool = false

    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    let socialIcons = ["google", "wechat", "linkedin"]
    let buttons = ["Login", "SignUp", "Submit"]
    
    
    func handleContinue() {
       DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
           self.onContinue()
       }
   }
    
    func onContinue() {
        self.onboardingState = "login"
    }
   
    
    func handleLoginButton() {
        withAnimation(.spring()) {
            onboardingState = "login"
        }
    }
    
    func handleSignUpButton() {
        withAnimation(.spring()) {
            onboardingState = "signUp"
        }
    }
    
    func Login() {
        guard validate() else {
            return
        }
            
        Auth.auth().signIn(withEmail: email, password: password)
            
    }
    
    func SignUp() {
        guard validate() else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] result, error in
            guard let userId = result?.user.uid else {
                return
            }
            self?.insertUserRecord(id: userId)
            
        }
    }
    
    private func insertUserRecord(id: String) {
        let newUser = User(id: id, 
                           name: name,
                           email: email,
                           joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())

    }
    
    
    private func validate() -> Bool {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty || !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            showAlert(title: "Please input your email.")
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            showAlert(title: "Please enter a valid email.")
            return false
        }
        
        //adjust password later
        guard password.count >= 1 else {
            showAlert(title: "Password should be at least 3 characters.")
            return false
        }
        
        if onboardingState == "signUp" {
            guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
                showAlert(title: "Please input your email.")
                return false
            }
            
            guard password == checkPassword || !checkPassword.trimmingCharacters(in: .whitespaces).isEmpty else {
                showAlert(title: "Password do not match or cannot be empty.")
                return false
            }
        }
        
        
        return true
    }
    
    
    func showAlert(title: String) {
        alertMsg = title
        showAlert.toggle()
    }
}
