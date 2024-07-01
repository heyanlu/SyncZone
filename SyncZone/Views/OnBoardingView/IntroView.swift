//
//  SwiftUIView.swift
//  SyncZone
//
//  Created by YL He on 6/28/24.
//

import SwiftUI

struct IntroView: View {
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
    @AppStorage("showLocationRequest") var showLocationRequest: Bool = false

    
    var body: some View {
        if isAuthenticated {
            if showLocationRequest {
                LocationRequestView()
            } else {
                MainTabView()
            }
        } else {
            OnBoardingView()
        }
    }
}



#Preview {
    IntroView()
}
