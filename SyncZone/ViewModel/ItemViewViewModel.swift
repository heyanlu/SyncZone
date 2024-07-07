//
//  ItemViewViewModel.swift
//  SyncZone
//
//  Created by YL He on 7/4/24.
//
import Foundation
import CoreLocation



class ItemViewViewModel: NSObject, ObservableObject {
    
    let cityToTimeZone: [String: String] = [
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
       "Buffalo": "America/New_York",
        "Edinburgh": "Europe/London"
        
    ]

    
//    private let apiKey = AppConfig.getIpGeoApiKey() ?? ""
//        private let apiUrl = "https://api.ipgeolocation.io/timezone"
//
//        @Published var cityToTimeZone: [String: String] = [:]
//        
//        override init() {
//            super.init()
//            fetchTimezones(for: "London, UK")
//        }
//        
//    func fetchTimezones(for city: String) {
//           guard let escapedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
//                 let apiURL = URL(string: "\(apiUrl)?apiKey=\(apiKey)&location=\(escapedCity)") else {
//               print("Invalid API URL")
//               return
//           }
//
//           var request = URLRequest(url: apiURL)
//           request.httpMethod = "GET"
//
//           URLSession.shared.dataTask(with: request) { data, response, error in
//               if let error = error {
//                   print("Error fetching timezone data: \(error.localizedDescription)")
//                   return
//               }
//
//               guard let data = data else {
//                   print("No data returned from API")
//                   return
//               }
//
//               if let jsonString = String(data: data, encoding: .utf8) {
//                   print("Raw JSON response: \(jsonString)")
//               } else {
//                   print("Unable to convert data to JSON string")
//               }
//
//               do {
//                   let decoder = JSONDecoder()
//                   decoder.keyDecodingStrategy = .convertFromSnakeCase // Handle snake_case keys
//
//                   let timezoneResponse = try decoder.decode(TimezoneResponse.self, from: data)
//
//                   DispatchQueue.main.async {
//                       self.cityToTimeZone[city] = timezoneResponse.timezone
//                       print("Timezone added for \(city): \(timezoneResponse.timezone)")
//                       if let localTime = self.localTime(for: city) {
//                           print("Local time for \(city): \(localTime)")
//                       } else {
//                           print("Failed to get local time for \(city)")
//                       }
//                   }
//
//               } catch let decodingError as DecodingError {
//                   print("Decoding error: \(decodingError.localizedDescription)")
//                   switch decodingError {
//                   case .dataCorrupted(let context):
//                       print(context.debugDescription)
//                   case .typeMismatch(let type, let context):
//                       print("Type '\(type)' mismatch:", context.debugDescription)
//                       print("codingPath:", context.codingPath)
//                   case .valueNotFound(let type, let context):
//                       print("Value '\(type)' not found:", context.debugDescription)
//                       print("codingPath:", context.codingPath)
//                   default:
//                       print("Unknown decoding error:", decodingError.localizedDescription)
//                   }
//               } catch {
//                   print("Error decoding JSON response: \(error.localizedDescription)")
//               }
//           }.resume()
//       }

       func localTime(for city: String) -> String? {
           guard let timezoneIdentifier = cityToTimeZone[city],
                 let timezone = TimeZone(identifier: timezoneIdentifier) else {
               print("Timezone identifier not found for \(city)")
               return nil
           }

           print("Timezone identifier for \(city): \(timezoneIdentifier)")

           let dateFormatter = DateFormatter()
           dateFormatter.timeZone = timezone
           dateFormatter.timeStyle = .short

           let currentTime = dateFormatter.string(from: Date())
           return currentTime
       }
    
    func calculateOverlap(start1: Date, end1: Date, city1: String, start2: Date, end2: Date, city2: String) -> String? {
        guard let tz1 = TimeZone(identifier: cityToTimeZone[city1] ?? ""),
              let tz2 = TimeZone(identifier: cityToTimeZone[city2] ?? "") else {
            print("Time zone not found for cities: \(city1) or \(city2)")
            return nil
        }
        
        let start1UTC = start1.addingTimeInterval(TimeInterval(-tz1.secondsFromGMT(for: start1)))
        let end1UTC = end1.addingTimeInterval(TimeInterval(-tz1.secondsFromGMT(for: end1)))
        
        let start2UTC = start2.addingTimeInterval(TimeInterval(-tz2.secondsFromGMT(for: start2)))
        let end2UTC = end2.addingTimeInterval(TimeInterval(-tz2.secondsFromGMT(for: end2)))
        
        let overlapStartUTC = max(start1UTC, start2UTC)
        var overlapEndUTC = min(end1UTC, end2UTC) // Declare overlapEndUTC as var to modify it
        
        guard overlapStartUTC < overlapEndUTC else {
            print("No overlap period")
            return "No overlap period"
        }
        
        if overlapStartUTC > overlapEndUTC {
            overlapEndUTC.addTimeInterval(24 * 60 * 60)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let overlapStartLocal = overlapStartUTC.addingTimeInterval(TimeInterval(tz1.secondsFromGMT(for: overlapStartUTC)))
        let overlapEndLocal = overlapEndUTC.addingTimeInterval(TimeInterval(tz1.secondsFromGMT(for: overlapEndUTC)))
        
        let start1String = dateFormatter.string(from: overlapStartLocal)
        let end1String = dateFormatter.string(from: overlapEndLocal)
        
        return "\(start1String) to \(end1String)"
    }

    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
