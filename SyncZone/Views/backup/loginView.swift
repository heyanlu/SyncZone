////
////  LoginView.swift
////  SyncZone
////
////  Created by YL He on 6/30/24.
////
//
//import SwiftUI
//
//struct loginView: View {
//    @State private var username: String = ""
//    @State private var password: String = ""
//    let socialIcons = ["google", "wechat", "linkedin"]
//    
//    @AppStorage("username") var currentUserName: String?
//    @AppStorage("password") var currentPassword: String?
//    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
//    
//    @State var alertMsg: String = ""
//    @State var showAlert: Bool = false
//    
//    @State private var isSignUpViewActive = false
//    
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                RadialGradient(gradient: Gradient(colors: [Color.red, Color("colorPrimary")]), center: .bottomTrailing, startRadius: 5, endRadius: UIScreen.main.bounds.height)
//                    .ignoresSafeArea()
//                
//                VStack(spacing: 25) {
//                    if isSignUpViewActive {
//                        signUpSection
//                            .transition(.move(edge: .trailing))
//                    } else {
//                        loginSection
//                            .transition(.move(edge: .leading))
//                    }
//                }
//                .padding(30)
//            }
//            .alert(isPresented: $showAlert) {
//                Alert(title: Text(alertMsg))
//            }
//            .background(
//                NavigationLink(destination: SyncTimeView(), isActive: $isAuthenticated) {
//                    EmptyView()
//                }
//                .hidden()
//            )
//        }
//    }
//    
//    private var loginSection: some View {
//        VStack(spacing: 25) {
//            Spacer()
//            
//            HStack {
//                Text("Username: ")
//                    .foregroundColor(.white)
//                    .font(.headline)
//                Spacer()
//            }
//            .padding(.horizontal)
//            
//            TextField("Enter your name...", text: $username)
//                .font(.headline)
//                .frame(height: 55)
//                .padding(.horizontal)
//                .background(Color.white)
//                .cornerRadius(10)
//            
//            HStack {
//                Text("Password: ")
//                    .foregroundColor(.white)
//                    .font(.headline)
//                Spacer()
//            }
//            .padding(.horizontal)
//            
//            SecureField("Enter your password...", text: $password)
//                .font(.headline)
//                .frame(height: 55)
//                .padding(.horizontal)
//                .background(Color.white)
//                .cornerRadius(10)
//            
//            HStack {
//                Text("New around here? ")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                Text("Create An Account")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .frame(height: 55)
//                    .frame(minWidth: 70)
//                    .cornerRadius(10)
//                    .overlay(
//                        Capsule(style: .continuous)
//                            .frame(height: 1)
//                            .offset(y: -7)
//                            .foregroundColor(.white), alignment: .bottom
//                    )
//                    .onTapGesture {
//                        withAnimation {
//                            isSignUpViewActive = true
//                        }
//                    }
//            }
//            
//            Spacer()
//            Spacer()
//            
//            HStack(spacing: 40) {
//                ForEach(socialIcons, id: \.self) { iconName in
//                    Image(iconName)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 30, height: 30)
//                }
//            }
//            
//            Button(action: handleSubmitButton) {
//                Text("Login")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .frame(height: 55)
//                    .frame(maxWidth: .infinity)
//                    .background(Color("colorPrimary"))
//                    .cornerRadius(10)
//                    .padding(.top, 10)
//            }
//        }
//    }
//    
//    private var signUpSection: some View {
//        signUpView()
//    }
//    
//    private func handleSubmitButton() {
//        guard username.count >= 1 else {
//            showAlert(title: "Name cannot be empty.")
//            return
//        }
//        guard password.count >= 3 else {
//            showAlert(title: "Password should be at least 3 characters.")
//            return
//        }
//        currentUserName = username
//        currentPassword = password
//        isAuthenticated = true
//    }
//    
//    private func showAlert(title: String) {
//        alertMsg = title
//        showAlert.toggle()
//    }
//}
//
//#Preview {
//    OnBoardingView()
//}
