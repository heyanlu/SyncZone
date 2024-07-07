//
//  LocationResponse.swift
//  SyncZone
//
//  Created by YL He on 7/6/24.
//

import Foundation

struct LocationsResponse: Decodable {
    let locations: [Location]

    enum CodingKeys: String, CodingKey {
        case locations
    }
}
