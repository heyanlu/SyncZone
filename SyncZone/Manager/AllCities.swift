////
////  AllCities.swift
////  SyncZone
////
////  Created by YL He on 7/1/24.
////
//
//import Foundation
//
//struct GeoNamesResponse: Codable {
//    let geonames: [GeoName]
//}
//
//struct GeoName: Codable {
//    let name: String
//    let postcode: String
//    let lattitude: String
//    let longitude: String
//}
//
//func fetchCities(completion: @escaping ([String]?) -> Void) {
//    let username = "yanlu"
//    let baseUrl = "https://api.geonames.org/searchJSON"
//
//    guard var components = URLComponents(string: baseUrl) else {
//        completion(nil)
//        return
//    }
//    
//    components.queryItems = [
//        URLQueryItem(name: "q", value: "cities"),
//        URLQueryItem(name: "maxRows", value: "1000"), // Adjust as needed
//        URLQueryItem(name: "username", value: username)
//    ]
//    
//    guard let url = components.url else {
//        completion(nil)
//        return
//    }
//    
//    URLSession.shared.dataTask(with: url) { (data, response, error) in
//        guard let data = data else {
//            if let error = error {
//                print("Error fetching cities:", error)
//            }
//            completion(nil)
//            return
//        }
//        
//        do {
//            let geoNamesResponse = try JSONDecoder().decode(GeoNamesResponse.self, from: data)
//            let cities = geoNamesResponse.geonames.map { $0.name }
//            completion(cities)
//        } catch {
//            print("Error decoding JSON:", error)
//            completion(nil)
//        }
//    }.resume()
//}
//
//
