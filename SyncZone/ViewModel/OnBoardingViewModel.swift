//
//  OnBoardingViewModel.swift
//  SyncZone
//
//  Created by YL He on 7/1/24.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class OnBoardingViewModel: ObservableObject {
    @Published var onboardingState: String = "welcome"
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var checkPassword: String = ""
    @Published var alertMsg: String = ""
    @Published var showAlert: Bool = false
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
    @Published var redirectToMainView: Bool = false
    
    @AppStorage("email") var currentEmail: String?
    @AppStorage("username") var currentUserName: String?
    @AppStorage("password") var currentPassword: String?
    

    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))

    let socialIcons = ["google", "wechat", "linkedin"]

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
    
    func handleLocationRequestButton() {
        withAnimation(.spring()) {
            onboardingState = "locationRequest"
        }
    }
    
    

    func Login() {
        guard loginValidate() else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                self.showAlert = true
                self.alertMsg = error.localizedDescription
                print("Login error: \(error.localizedDescription)")
            } else {
                print("Login successful!")
                self.isAuthenticated = true
                self.currentEmail = self.email
            }
        }
    }


    func SignUp() {
        guard signUpValidate() else {
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.showAlert(title: "Sign-up failed. \(error.localizedDescription)")
                return
            }

            self?.currentUserName = self?.name ?? ""
            self?.currentEmail = self?.email ?? ""
            self?.checkPassword = self?.password ?? ""

            if let userId = result?.user.uid {
                self?.insertUserRecord(id: userId)
                self?.isAuthenticated = true
                self?.redirectToMainView = true
                
            }
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
    
    private func loginValidate() -> Bool {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            showAlert(title: "Please input your email.")
            return false
        }

        guard email.contains("@") && email.contains(".") else {
            showAlert(title: "Please enter a valid email.")
            return false
        }

        guard password.count >= 6 else {
            showAlert(title: "Password should be at least 6 characters.")
            return false
        }

        return true
    }
    
    
    private func signUpValidate() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            showAlert(title: "Please input your name.")
            return false
        }

        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            showAlert(title: "Please input your email.")
            return false
        }

        guard email.contains("@") && email.contains(".") else {
            showAlert(title: "Please enter a valid email.")
            return false
        }

        guard password.count >= 6 else {
            showAlert(title: "Password should be at least 6 characters.")
            return false
        }

        guard password == checkPassword else {
            showAlert(title: "Passwords do not match.")
            return false
        }

        return true
    }

    func showAlert(title: String) {
        alertMsg = title
        showAlert.toggle()
    }
}
