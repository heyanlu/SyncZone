//
//  ItemViewViewModel.swift
//  SyncZone
//
//  Created by YL He on 7/4/24.
//

import Foundation
import CoreLocation

class ItemViewViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    //update API later
    let cityToTimezone: [String: String] = [
        "Tokyo": "Asia/Tokyo",
        "New York": "America/New_York",
        "São Paulo": "America/Sao_Paulo",
        "Seoul": "Asia/Seoul",
        "Mexico City": "America/Mexico_City",
        "Jakarta": "Asia/Jakarta",
        "Shanghai": "Asia/Shanghai",
        "Lagos": "Africa/Lagos",
        "Delhi": "Asia/Kolkata",
        "Cairo": "Africa/Cairo",
        "Mumbai": "Asia/Kolkata",
        "Beijing": "Asia/Shanghai",
        "Dhaka": "Asia/Dhaka",
        "Osaka": "Asia/Tokyo",
        "Karachi": "Asia/Karachi",
        "Manila": "Asia/Manila",
        "Moscow": "Europe/Moscow",
        "Istanbul": "Europe/Istanbul",
        "Bangkok": "Asia/Bangkok",
        "Lahore": "Asia/Karachi",
        "Rio de Janeiro": "America/Sao_Paulo",
        "Guangzhou": "Asia/Shanghai",
        "Kinshasa": "Africa/Kinshasa",
        "Los Angeles": "America/Los_Angeles",
        "Tianjin": "Asia/Shanghai",
        "Bengaluru": "Asia/Kolkata",
        "Paris": "Europe/Paris",
        "Chennai": "Asia/Kolkata",
        "Lima": "America/Lima",
        "London": "Europe/London",
        "New Delhi": "Asia/Kolkata",
        "Ho Chi Minh City": "Asia/Ho_Chi_Minh",
        "Shenzhen": "Asia/Shanghai",
        "Hyderabad": "Asia/Kolkata",
        "Nanjing": "Asia/Shanghai",
        "Ahmedabad": "Asia/Kolkata",
        "Kolkata": "Asia/Kolkata",
        "Bangalore": "Asia/Kolkata",
        "Tehran": "Asia/Tehran",
        "Shenyang": "Asia/Shanghai",
        "Bogotá": "America/Bogota",
        "Wuhan": "Asia/Shanghai",
        "Chongqing": "Asia/Chongqing",
        "Chengdu": "Asia/Shanghai",
        "Dongguan": "Asia/Shanghai",
        "Ningbo": "Asia/Shanghai",
        "Hong Kong": "Asia/Hong_Kong",
        "Baghdad": "Asia/Baghdad",
        "Changsha": "Asia/Shanghai",
        "Hanoi": "Asia/Ho_Chi_Minh",
        "Riyadh": "Asia/Riyadh",
        "Singapore": "Asia/Singapore",
        "Santiago": "America/Santiago",
        "Saint Petersburg": "Europe/Moscow",
        "Surat": "Asia/Kolkata",
        "Madrid": "Europe/Madrid",
        "Toronto": "America/Toronto",
        "Pune": "Asia/Kolkata",
        "Jaipur": "Asia/Kolkata",
        "Dallas": "America/Chicago",
        "Philadelphia": "America/New_York",
        "Atlanta": "America/New_York",
        "Barcelona": "Europe/Madrid",
        "Houston": "America/Chicago",
        "Phoenix": "America/Phoenix",
        "San Antonio": "America/Chicago",
        "San Diego": "America/Los_Angeles",
        "San Jose": "America/Los_Angeles",
        "San Francisco": "America/Los_Angeles",
        "Seattle": "America/Los_Angeles",
        "Boston": "America/New_York",
        "Miami": "America/New_York",
        "Washington D.C.": "America/New_York",
        "Denver": "America/Denver",
        "Las Vegas": "America/Los_Angeles",
        "Austin": "America/Chicago",
        "Minneapolis": "America/Chicago",
        "Detroit": "America/Detroit",
        "Orlando": "America/New_York",
        "Tampa": "America/New_York",
        "St. Louis": "America/Chicago",
        "Salt Lake City": "America/Denver",
        "Nashville": "America/Chicago",
        "Indianapolis": "America/Indianapolis",
        "Kansas City": "America/Chicago",
        "Charlotte": "America/New_York",
        "Columbus": "America/New_York",
        "Raleigh": "America/New_York",
        "Pittsburgh": "America/New_York",
        "Cincinnati": "America/New_York",
        "Milwaukee": "America/Chicago",
        "Jacksonville": "America/New_York",
        "Oklahoma City": "America/Chicago",
        "Memphis": "America/Chicago",
        "Louisville": "America/New_York",
        "Richmond": "America/New_York",
        "New Orleans": "America/Chicago",
        "Buffalo": "America/New_York"
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
