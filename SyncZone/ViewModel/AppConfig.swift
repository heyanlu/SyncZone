//
//  AppConfig.swift
//  SyncZone
//
//  Created by YL He on 7/6/24.
//

import Foundation

struct AppConfig {
    static func getAPIKey() -> String? {
        guard let path = Bundle.main.path(forResource: "config", ofType: "plist") else {
            print("Config.plist not found")
            return nil
        }
        
        guard let config = NSDictionary(contentsOfFile: path) as? [String: String] else {
            print("Error loading Config.plist")
            return nil
        }
        
        guard let apiKey = config["apiKey"] else {
            print("API key not found in Config.plist")
            return nil
        }
        
        return apiKey
    }
    
    static func getIpGeoApiKey() -> String? {
        guard let path = Bundle.main.path(forResource: "config2", ofType: "plist") else {
            print("Config2.plist not found")
            return nil
        }
        
        guard let config = NSDictionary(contentsOfFile: path) as? [String: String] else {
            print("Error loading Config2.plist")
            return nil
        }
        
        guard let apiKey = config["apiKey"] else {
            print("API key not found in Config.plist")
            return nil
        }
        
        print("API Key: \(apiKey)")

        return apiKey
    }
}
