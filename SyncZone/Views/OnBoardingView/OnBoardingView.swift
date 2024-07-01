//
//  NewBoardingView.swift
//  SyncZone
//
//  Created by YL He on 6/30/24.
//

import SwiftUI

struct OnBoardingView: View {
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
    @State private var shouldNavigate = false
    
    var body: some View {
        NavigationView {
            VStack {
                WelcomeView()
                    .onAppear {
                        startWelcomeTimer()
                    }
                
                NavigationLink(destination: destinationView(), isActive: $shouldNavigate) {
                    EmptyView()
                }
                .hidden()
            }
        }
    }

    private func destinationView() -> some View {
        if isAuthenticated {
            return AnyView(SyncTimeView())
        } else {
            return AnyView(LoginView())
        }
    }

    private func startWelcomeTimer() {
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            withAnimation(.spring()) {
                shouldNavigate = true
            }
        }
    }
}

#Preview {
    OnBoardingView()
}
