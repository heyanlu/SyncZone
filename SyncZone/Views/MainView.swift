//
//  SwiftUIView.swift
//  SyncZone
//
//  Created by YL He on 6/28/24.
//

import SwiftUI

struct MainView: View {
//    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
//    @AppStorage("showLocationRequest") var showLocationRequest: Bool = false
    
    @StateObject var viewModel = MainViewModel()

    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            TabView {
                SyncZoneView(userId: viewModel.currentUserId)
                    .tabItem {
                        Image(systemName: "clock.badge.checkmark")
                        Text("Sync")
                    }
                ChatGroupView()
                    .tabItem {
                        Image(systemName: "message")
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
        }
    }
    
    
    
}


#Preview {
    MainView()
}
