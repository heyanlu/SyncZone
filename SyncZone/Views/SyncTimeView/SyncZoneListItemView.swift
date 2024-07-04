//
//  SyncZoneListItemView.swift
//  SyncZone
//
//  Created by YL He on 7/2/24.
//
import SwiftUI

struct SyncZoneListItemView: View {
    let item: SyncZoneListItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.listName)
                    .font(.title)
                    .bold()
                
                Text(selectedCitiesDisplay)
                    .foregroundColor(.gray)
                
                HStack {
                    Text("From: \(formattedDate(item.startTime))")
                    Text("To: \(formattedDate(item.endTime))")
                }
                .font(.subheadline)
                .foregroundColor(.gray)
            }
            .padding()
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}



extension SyncZoneListItemView {
    private var selectedCitiesDisplay: String {
        if item.selectedCities.count > 3 {
            return "\(item.selectedCities.prefix(3).joined(separator: ", "))..."
        } else {
            return item.selectedCities.joined(separator: ", ")
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}



#Preview {
    
    SyncZoneListItemView(item: .init(
        id: "1",
        listName: "Sample List",
        selectedCities: ["New York", "Los Angeles", "San Francisco", "Chicago"],
        startTime: Date(),
        endTime: Date(),
                        
        createdDate: Date().timeIntervalSince1970))
}



