//
//  Misson.swift
//  Moonshot
//
//  Created by Kurt Higa on 2/17/24.
//

import Foundation

//nested struct
struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}
