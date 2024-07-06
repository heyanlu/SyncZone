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
    
    var body: some View {
        VStack {
            Button {
                //action
            } label: {
              Text("Skip")
                .bold()
                .foregroundColor(Color("colorPrimary"))
            }
            
            
            Spacer()
            Image(systemName: "paperplane.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(Color("colorPrimary"))

            Text("Share your location with us? ")
                .multilineTextAlignment(.center)
                .frame(width: 140)
                .padding()
            Spacer()
            
            VStack(spacing: 20) {
                SZButton(title: "Allow location", foregroundColor: Color.white, background: Color("colorPrimary"), action: {
                    locationManager.requestLocation()
                })
                    .font(.headline)
                    .padding()
                
            }
        }
    }
}


#Preview {
    LocationRequestView()
}
