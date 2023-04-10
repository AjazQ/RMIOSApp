//
//  RMCharacterStatus.swift
//  RickAndMorty
//
//  Created by PS19Developer on 31/03/2023.
//

import Foundation
enum RMCharacterStatus: String, Codable{
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
    
    var text: String{
        switch self {
        case .alive,.dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
