//
//  InputFieldView.swift
//  SyncZone
//
//  Created by YL He on 7/1/24.
//

import SwiftUI

struct InputFieldView: View {
    let title: String
    let placeholder: String 
    @Binding var text: String
    let isSecure: Bool

    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.white)
                .font(.headline)
            
            if isSecure {
                SecureField(placeholder, text: $text)
                    .font(.headline)
                    .frame(height: 55)
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(10)
                    .textInputAutocapitalization(.none)
            } else {
                TextField(placeholder, text: $text)
                    .font(.headline)
                    .frame(height: 55)
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(10)
                    .textInputAutocapitalization(.none)
            }
        }
    }
}


struct InputFieldView_Previews: PreviewProvider {
    @State static var text1: String = ""
    
    static var previews: some View {
        InputFieldView(title: "Username:", placeholder: "Enter your name...", text: $text1, isSecure: false)
            .padding()
        
    }
}
