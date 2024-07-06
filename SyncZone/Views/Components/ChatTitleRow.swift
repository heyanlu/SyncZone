//
//  ChatTitleRow.swift
//  SyncZone
//
//  Created by YL He on 7/6/24.
//

import SwiftUI

struct ChatTitleRow: View {
    var imageUrl: URL? = URL(string: "https://via.placeholder.com/50")
    var name = "Name"
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: imageUrl) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(50)
            } placeholder: {
                ProgressView()
            }
            
            Text(name)
                .font(.title).bold()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    ChatTitleRow()
        .background(Color("colorPrimary"))
}
