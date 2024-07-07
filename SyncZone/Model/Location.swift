//
//  Location.swift
//  SyncZone
//
//  Created by YL He on 7/6/24.
//

import Foundation

struct Location: Decodable {
    let name: String
    let latitude: Double
    let longitude: Double
    let country: String
    let population: Int
    let isCapital: Bool

    enum CodingKeys: String, CodingKey {
        case name
        case latitude
        case longitude
        case country
        case population
        case isCapital = "is_capital"
    }
}
