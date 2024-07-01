//
//  SignUpView.swift
//  SyncZone
//
//  Created by YL He on 6/30/24.
//

import SwiftUI

struct signUpView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var checkPassword: String = ""

    @AppStorage("username") var currentUserName: String?
    @AppStorage("password") var currentPassword: String?
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false

    @State private var alertMsg: String = ""
    @State private var showAlert: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [Color.red, Color("colorPrimary")]), center: .bottomTrailing, startRadius: 5, endRadius: UIScreen.main.bounds.height)
                    .ignoresSafeArea()

                VStack(spacing: 25) {
                    Spacer()
                    HStack {
                        Text("Username: ")
                            .foregroundColor(.white)
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.horizontal)

                    TextField("Enter your name...", text: $username)
                        .font(.headline)
                        .frame(height: 55)
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(10)

                    HStack {
                        Text("Password: ")
                            .foregroundColor(.white)
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.horizontal)

                    SecureField("Enter your password...", text: $password)
                        .font(.headline)
                        .frame(height: 55)
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(10)

                    HStack {
                        Text("Check password: ")
                            .foregroundColor(.white)
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.horizontal)

                    SecureField("Enter your password again...", text: $checkPassword)
                        .font(.headline)
                        .frame(height: 55)
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(10)

                    Spacer()

                    Button(action: handleSubmitButton) {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color("colorPrimary"))
                            .cornerRadius(10)
                            .padding(.top, 10)
                    }
                }
                .padding(30)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertMsg))
                }
                .background(
                    NavigationLink(destination: LocationRequestView(), isActive: $isAuthenticated) {
                        EmptyView()
                    }
                    .hidden()
                )
            }
        }
    }

    private func handleSubmitButton() {
        guard username.count >= 1 else {
            showAlert(title: "Name cannot be empty.")
            return
        }
        guard password.count >= 3 else {
            showAlert(title: "Password should be at least 3 characters.")
            return
        }
        guard password == checkPassword else {
            showAlert(title: "Passwords do not match.")
            return
        }
        
        currentUserName = username
        currentPassword = password
        isAuthenticated = true
    }

    private func showAlert(title: String) {
        alertMsg = title
        showAlert.toggle()
    }
}

#Preview {
    signUpView()
}
