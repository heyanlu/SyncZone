//
//  LocationRequest.swift
//  SyncZone
//
//  Created by YL He on 6/29/24.
//
import SwiftUI

struct LocationRequestView: View {
    @StateObject var locationManager = LocationManager()
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
//    @AppStorage("locationRequested") var locationRequested: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "paperplane.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Text("Share your location with us? ")
                .font(.headline)
                .multilineTextAlignment(.center)
                .frame(width: 140)
                .padding()
            Spacer()
            
            VStack(spacing: 20) {
                SZButton(title: "Allow location", foregroundColor: Color.white, background: Color("colorPrimary"), action: {
                    locationManager.requestLocation()
//                    locationRequested = true
                })
                    .font(.headline)
                
                SZButton(title: "Allow location", foregroundColor: Color.white, background: Color.gray.opacity(0.4), action: {
//                    locationRequested = true
                })
            }
        }
        .foregroundColor(.orange)
        .background(
            NavigationLink(destination: MainTabView(), isActive: $isAuthenticated) {
                EmptyView()
            }
            .hidden()
        )
    }
}


#Preview {
    LocationRequestView()
}
