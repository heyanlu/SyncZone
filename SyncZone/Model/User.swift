//
//  User.swift
//  SyncZone
//
//  Created by YL He on 6/30/24.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
