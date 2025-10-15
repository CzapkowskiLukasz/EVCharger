//
//  City.swift
//  EVChargerr
//
//  Created by Łukasz on 15/10/2025.
//

import Foundation

struct City: Codable, Identifiable {
    let id: UUID = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    let country: String
}
