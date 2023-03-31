//
//  RMLocation.swift
//  RickAndMorty
//
//  Created by PS19Developer on 30/03/2023.
//

import Foundation

struct RMLocation: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
    
}
