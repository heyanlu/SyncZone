//
//  MainTabView.swift
//  SyncZone
//
//  Created by YL He on 6/30/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            SyncTimeView()
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
    }
}

#Preview("MainTabView Preview") {
    MainTabView()
}
