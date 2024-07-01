//
//  SyncZoneApp.swift
//  SyncZone
//
//  Created by YL He on 6/28/24.
//
import Firebase
import SwiftUI

@main
struct SyncZoneApp: App {
    init(){
        FirebaseApp.configure()
        print("Connect test")
    }
  
    var body: some Scene {
        WindowGroup {
            IntroView()
            //MapView()
            
        }
    }
}
