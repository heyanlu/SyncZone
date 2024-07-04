//
//  SyncTimeGroup.swift
//  SyncZone
//
//  Created by YL He on 6/30/24.
//

import Foundation


struct SyncZoneListItem: Codable, Identifiable {
    let id: String
    var listName: String
    var selectedCities: [String]
    var startTime: Date
    var endTime: Date
    var createdDate: TimeInterval
}
