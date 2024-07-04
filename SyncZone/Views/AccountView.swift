//
//  ProfileView.swift
//  SyncZone
//
//  Created by YL He on 6/28/24.
//
import MapKit
import SwiftUI

struct AccountView: View {
    
    @AppStorage("username") var currentUserName: String?
    @AppStorage("password") var currentPassword: String?
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
    
    @ObservedObject var locationManager = LocationManager.shared
    
    @StateObject var viewMode = AccountViewModel()

    init() {
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(Color("colorPrimary"))
                
                Text(currentUserName ?? "Your name here")
                    .font(.title)
                
                LocationView()
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Button(action: signOut) {
                    Text("Sign Out")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color("colorPrimary"))
                        .cornerRadius(10)
                }
            }
            .font(.title)
            .padding()
        }
    }
        
    func signOut() {
        currentUserName = nil
        currentPassword = nil
        withAnimation(.spring()) {
            isAuthenticated = false
        }
    }
}

#Preview {
    AccountView()
}
