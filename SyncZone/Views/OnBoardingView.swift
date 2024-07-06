//
//  OnBoardingView.swift
//  SyncZone
//
//  Created by YL He on 6/28/24.
//
import SwiftUI


struct OnBoardingView: View {
    @AppStorage("username") var currentUserName: String?
    @AppStorage("password") var currentPassword: String?
    
    @StateObject var viewModel = OnBoardingViewModel()
    @EnvironmentObject var locationManager: LocationManager
    
    let socialIcons = ["google", "wechat", "linkedin"]
    let buttons = ["Login", "SignUp", "Submit"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                ZStack {
                    switch viewModel.onboardingState {
                    case "welcome":
                        welcomeSection
                            .transition(viewModel.transition)
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
                
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text(viewModel.alertMsg))
            }
        }
        .onChange(of: viewModel.isAuthenticated) { isAuthenticated in
            if isAuthenticated {
                viewModel.redirectToMainView = true
            }
        }
        .background(
            NavigationLink(
                destination: MainView(),
                isActive: $viewModel.redirectToMainView,
                label: {
                    EmptyView()
                })
                .hidden()
        )
    }
    
}


// MARK: COMPONENTS
extension OnBoardingView {
    private var welcomeSection: some View {
        VStack(spacing: 40) {
            Spacer()
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            Text("SyncZone")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(Color("colorPrimary"))
                .overlay(
                    Capsule(style: .continuous)
                        .frame(height: 3)
                        .offset(y: 5)
                        .foregroundColor(Color("colorPrimary")), alignment: .bottom
                )
            Text("Sync Time, Connect Minds")
                .fontWeight(.medium)
                .foregroundColor(Color("colorPrimary"))
            Spacer()
            Spacer()
        }
        .onAppear {
            viewModel.handleContinue()
        }
        .padding(30)
    }
   
    private var loginSection: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color.red, Color("colorPrimary")]), center: .bottomTrailing, startRadius: 5, endRadius: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                Spacer()
                Spacer()
              
                InputFieldView(title: "Email: ", placeholder: "Enter your email...", text: $viewModel.email, isSecure: false)
                
                InputFieldView(title: "Password: ", placeholder: "Enter your password...", text: $viewModel.password, isSecure: true)
                
                SZButton(title: viewModel.onboardingState.capitalized, foregroundColor: Color.white, background: Color("colorPrimary"), action: viewModel.Login)
                    .font(.headline)

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
                InputFieldView(title: "Name: ", placeholder: "Enter your name...", text: $viewModel.name, isSecure: false)
                
                InputFieldView(title: "Email: ", placeholder: "Enter your email...", text: $viewModel.email, isSecure: false)
                
                InputFieldView(title: "Password: ", placeholder: "Enter your password...", text: $viewModel.password, isSecure: true)
                
                InputFieldView(title: "Check Password: ", placeholder: "Enter your password again...", text: $viewModel.checkPassword, isSecure: true)
                
                
                SZButton(title: viewModel.onboardingState.capitalized, foregroundColor: Color.white, background: Color("colorPrimary"), action: viewModel.SignUp)
                    .font(.headline)
                
                HStack {
                    Text("Already have an account?")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(minWidth: 70)
                        .cornerRadius(10)
                        .overlay(
                            Capsule(style: .continuous)
                                .frame(height: 1)
                                .offset(y: -10)
                                .foregroundColor(.white), alignment: .bottom
                        )
                        .onTapGesture {
                            viewModel.handleLoginButton()
                        }
                }
                Spacer()
                Spacer()
            }
            .padding(30)
        }
    }
}


#Preview {
    OnBoardingView()
}
