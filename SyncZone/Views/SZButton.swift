//
//  SZButton.swift
//  SyncZone
//
//  Created by YL He on 6/30/24.
//

import SwiftUI

struct SZButton: View {
    let title: String
    let foregroundColor: Color
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .foregroundColor(foregroundColor)
                .background(background)
                .clipShape(Capsule())
                .padding()
        }
    }
}

#Preview {
    SZButton(title: "Value", foregroundColor: Color.white, background: Color("colorPrimary"), action: {
        // Action closure
        print("Button clicked")
    })
}
