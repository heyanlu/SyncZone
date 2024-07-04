////
////  MainTabView.swift
////  SyncZone
////
////  Created by YL He on 6/30/24.
////
//
//import SwiftUI
//
//struct MainTabView: View {
//    @StateObject var viewModel = MainViewModel()
//
//    var body: some View {
//        TabView {
//            SyncTimeView(userId: viewModel.currentUserId)
//                .tabItem {
//                    Image(systemName: "clock.badge.checkmark")
//                    Text("Sync")
//                }
//            ChatGroupView()
//                .tabItem {
//                    Image(systemName: "message")
//                    Text("Chat")
//                }
//            AccountView()
//                .tabItem {
//                    Image(systemName: "person")
//                    Text("Account")
//                }
//        }
//        .accentColor(Color("colorPrimary"))
//    }
//}
//
//#Preview("MainTabView Preview") {
//    MainTabView()
//}
