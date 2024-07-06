//
//  ItemViewViewModel.swift
//  SyncZone
//
//  Created by YL He on 7/4/24.
//

import Foundation
import CoreLocation

class ItemViewViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    let cityToTimezone: [String: String] = [
        "New York": "America/New_York",
        "Los Angeles": "America/Los_Angeles",
        "Chicago": "America/Chicago",
        "Houston": "America/Chicago",
        "Phoenix": "America/Phoenix",
        "Philadelphia": "America/New_York",
        "San Antonio": "America/Chicago",
        "San Diego": "America/Los_Angeles",
        "Dallas": "America/Chicago",
        "San Jose": "America/Los_Angeles",
        "San Francisco": "America/Los_Angeles",
        "London": "Europe/London"
    ]

    
    func localTime(for city: String) -> String? {

        
        guard let timezoneIdentifier = cityToTimezone[city],
              let timezone = TimeZone(identifier: timezoneIdentifier) else {
            return nil 
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timezone
        dateFormatter.timeStyle = .short
        
        let currentTime = dateFormatter.string(from: Date())
        return currentTime
    }
    
    
    
    func calculateOverlap(start1: Date, end1: Date, city1: String, start2: Date, end2: Date, city2: String) -> String? {
        guard let tz1 = cityToTimezone[city1], let tz2 = cityToTimezone[city2] else {
            print("Time zone not found for cities: \(city1) or \(city2)")
            return nil
        }
        
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let timezone1 = TimeZone(identifier: tz1),
              let timezone2 = TimeZone(identifier: tz2) else {
            print("Invalid time zone identifiers: \(tz1) or \(tz2)")
            return nil
        }

        let start1UTC = calendar.date(byAdding: .second, value: -timezone1.secondsFromGMT(for: start1), to: start1)!
        let end1UTC = calendar.date(byAdding: .second, value: -timezone1.secondsFromGMT(for: end1), to: end1)!
        
        let start2UTC = calendar.date(byAdding: .second, value: -timezone2.secondsFromGMT(for: start2), to: start2)!
        let end2UTC = calendar.date(byAdding: .second, value: -timezone2.secondsFromGMT(for: end2), to: end2)!
        
        let overlapStartUTC = max(start1UTC, start2UTC)
        let overlapEndUTC = min(end1UTC, end2UTC)
        
        guard overlapStartUTC < overlapEndUTC else {
            print("No overlap period")
            return "No overlap period"
        }
        
        // Convert overlap times to local time zones
        let overlapStartLocal1 = calendar.date(byAdding: .second, value: timezone1.secondsFromGMT(for: overlapStartUTC), to: overlapStartUTC)!
        let overlapEndLocal1 = calendar.date(byAdding: .second, value: timezone1.secondsFromGMT(for: overlapEndUTC), to: overlapEndUTC)!
        let overlapStartLocal2 = calendar.date(byAdding: .second, value: timezone2.secondsFromGMT(for: overlapStartUTC), to: overlapStartUTC)!
        let overlapEndLocal2 = calendar.date(byAdding: .second, value: timezone2.secondsFromGMT(for: overlapEndUTC), to: overlapEndUTC)!
        
        let start1String = dateFormatter.string(from: overlapStartLocal1)
        let end1String = dateFormatter.string(from: overlapEndLocal1)
        _ = dateFormatter.string(from: overlapStartLocal2)
        _ = dateFormatter.string(from: overlapEndLocal2)
        
        return "\(start1String) to \(end1String)"
    }

    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
