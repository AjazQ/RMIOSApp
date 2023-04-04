//
//  RMCharacterGender.swift
//  RickAndMorty
//
//  Created by PS19Developer on 31/03/2023.
//

import Foundation

enum RMCharacterGender: String , Codable  {
    //('Female', 'Male', 'Genderless' or 'unknown')
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case `unknown` = "unknown"
}
