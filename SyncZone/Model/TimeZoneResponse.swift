//
//  TimeZoneResponse.swift
//  SyncZone
//
//  Created by YL He on 7/6/24.
//

import Foundation

struct TimezoneResponse: Codable {
    let geo: GeoInfo
    let timezone: String
    let timezoneOffset: Int
    let date: String
    let dateTime: String
    let dateTimeTxt: String
    let dateTimeWti: String
    let dateTimeYmd: String
    let dateTimeUnix: Double
    let time24: String
    let time12: String
    let week: Int
    let month: Int
    let year: Int  // Change type to Int
    let yearAbbr: String
    let isDst: Bool
    let dstSavings: Int
    let dstExists: Bool
    let dstStart: DstInfo
    let dstEnd: DstInfo
    
    struct GeoInfo: Codable {
        let location: String
        let country: String
        let state: String
        let city: String
        let locality: String
        let latitude: Double
        let longitude: Double
    }
    
    struct DstInfo: Codable {
        let utcTime: String
        let duration: String
        let gap: Bool
        let dateTimeAfter: String
        let dateTimeBefore: String
        let overlap: Bool
    }
}
