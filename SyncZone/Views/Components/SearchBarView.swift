//
//  SearchBarVIew.swift
//  SyncZone
//
//  Created by YL He on 7/5/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var placeholder: String

    
    var body: some View {
        HStack {
            TextField(placeholder, text: $searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        Spacer()
                    }
                )
                .padding(.horizontal, 10)
        }
        .padding(.top, 10)
    }
}

#Preview {
    SearchBarView(searchText: .constant(""), placeholder: "Search...")
}
