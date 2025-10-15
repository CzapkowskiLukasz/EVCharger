//
//  Country.swift
//  EVChargerr
//
//  Created by Łukasz on 15/10/2025.
//

import Foundation


struct Country: Codable {
    let name: Name
    let cca2: String
    let cca3: String
    let capital: [String]?
    let region: String
    let subregion: String?
    let population: Int?
    let flag: String?
    let flags: Flags
    let coatOfArms: CoatOfArms?
    let maps: Maps?
}

struct Name: Codable {
    let common: String
    let official: String
    let nativeName: [String: NativeName]?
}

struct NativeName: Codable {
    let official: String
    let common: String
}

struct Flags: Codable {
    let png: String?
    let svg: String?
    let alt: String?
}

struct CoatOfArms: Codable {
    let png: String?
    let svg: String?
}

struct Maps: Codable {
    let googleMaps: String?
    let openStreetMaps: String?
}
