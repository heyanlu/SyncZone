//
//  WelcomeView.swift
//  SyncZone
//
//  Created by YL He on 6/30/24.
//

import SwiftUI

struct WelcomeView: View {
    var onContinue: () -> Void

    var body: some View {
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
//            Text("Continuing automatically...")
//                .font(.title2)
//                .foregroundColor(.gray)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                onContinue()
            }
        }
        .padding(30)
    }
}

#Preview {
    WelcomeView(onContinue: {})
}
