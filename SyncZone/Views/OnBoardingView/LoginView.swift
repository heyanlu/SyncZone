//
//  OnBoardingView.swift
//  SyncZone
//
//  Created by YL He on 6/28/24.
//
import SwiftUI


struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @EnvironmentObject var locationManager: LocationManager
    
    let socialIcons = ["google", "wechat", "linkedin"]
    let buttons = ["Login", "SignUp", "Submit"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                ZStack {
                    switch viewModel.onboardingState {
                    case "login":
                        loginSection
                            .transition(viewModel.transition)
                    case "signUp":
                        signUpSection
                            .transition(viewModel.transition)
                    default:
                        RoundedRectangle(cornerRadius: 25.0)
                            .foregroundColor(Color("colorBackground")) }
                }
                
                VStack {
                    Spacer()
                    if viewModel.onboardingState == "login" || viewModel.onboardingState == "signUp" {
                        SZButton(title: viewModel.onboardingState.capitalized, foregroundColor: Color.white, background: Color("colorPrimary"), action: viewModel.handleSubmitButton)
                            .font(.headline)
                    }
                }
                .padding(10)
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text(viewModel.alertMsg))
            }
            if viewModel.showLocationRequest {
                LocationRequestView()
            }
        }
    }
}


// MARK: COMPONENTS
extension LoginView {
   
    private var loginSection: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color.red, Color("colorPrimary")]), center: .bottomTrailing, startRadius: 5, endRadius: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                Spacer()
                
              
                InputFieldView(title: "Email: ", placeholder: "Enter your email...", text: $viewModel.email, isSecure: false)
                
                InputFieldView(title: "Password: ", placeholder: "Enter your password...", text: $viewModel.password, isSecure: true)

                HStack {
                    Text("New around here? ")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Create An Account")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(minWidth: 70)
                        .cornerRadius(10)
                        .overlay(
                            Capsule(style: .continuous)
                                .frame(height: 1)
                                .offset(y: -7)
                                .foregroundColor(.white), alignment: .bottom
                        )
                        .onTapGesture {
                            viewModel.handleSignUpButton()
                        }
                }
                
                Spacer()
                
                HStack(spacing: 40) {
                    ForEach(socialIcons, id: \.self) { iconName in
                        Image(iconName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                }
                Spacer()
            }
            .padding(30)
        }
    }
    
    private var signUpSection: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color.red, Color("colorPrimary")]), center: .bottomTrailing, startRadius: 5, endRadius: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                Spacer()
                
                InputFieldView(title: "Email: ", placeholder: "Enter your email...", text: $viewModel.email, isSecure: false)
                
                InputFieldView(title: "Password: ", placeholder: "Enter your password...", text: $viewModel.password, isSecure: true)
                
                InputFieldView(title: "Check Password: ", placeholder: "Enter your password again...", text: $viewModel.checkPassword, isSecure: true)

                Spacer()
                Spacer()
            }
            .padding(30)
        }
    }
}


#Preview {
    LoginView()
}
