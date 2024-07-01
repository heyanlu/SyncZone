//
//  LoginViewModel.swift
//  SyncZone
//
//  Created by YL He on 7/1/24.
//
import Foundation
import SwiftUI

//Function of login 
class LoginViewModel: ObservableObject {
    @Published var onboardingState: String = "login"
    
//    @Published var username: String = ""
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
    
    func handleSubmitButton() {
        if validate() {
            currentEmail = email
            currentPassword = password
            isAuthenticated = true
            
            //request user location after sign up 
            if onboardingState == "signUp" {
                showLocationRequest = true
            }
            
        }
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
            guard password == checkPassword else {
                showAlert(title: "Passwords do not match.")
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
