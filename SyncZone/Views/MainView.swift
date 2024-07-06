//
//  SwiftUIView.swift
//  SyncZone
//
//  Created by YL He on 6/28/24.
//

import SwiftUI

struct MainView: View {
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
    @StateObject var viewModel = MainViewModel()

    var body: some View {
        if isAuthenticated, viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            TabView {
                SyncZoneView(userId: viewModel.currentUserId)
                    .tabItem {
                        Image(systemName: "clock.badge.checkmark")
                        Text("Sync")
                    }
                ChatView()
                    .tabItem {
                        Image(systemName: "ellipsis.message")
                        Text("Chat")
                    }
                AccountView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Account")
                    }
            }
            .accentColor(Color("colorPrimary"))
        } else {
            OnBoardingView()
                .environmentObject(viewModel)
        }
    }
    
    
    
}


#Preview {
    MainView()
}
