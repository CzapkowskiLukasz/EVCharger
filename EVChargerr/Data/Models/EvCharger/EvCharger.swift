//
//  EvCharger.swift
//  EVChargerr
//
//  Created by Łukasz on 10/10/2025.
//

import Foundation
import CoreLocation

struct EVCharger: Codable, Identifiable {
    let id = UUID() // lokalny identyfikator dla SwiftUI
    let isActive: Bool
    let name: String
    let address: String
    let city: String
    let region: String
    let country: String
    let latitude: Double
    let longitude: Double
    let connections: [EVConnection]
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    enum CodingKeys: String, CodingKey {
        case isActive = "is_active"
        case name
        case address
        case city
        case region
        case country
        case latitude
        case longitude
        case connections
    }
}

struct EVConnection: Codable {
    let typeName: String
    let typeOfficial: String
    let level: Int
    let numConnectors: Int
    
    enum CodingKeys: String, CodingKey {
        case typeName = "type_name"
        case typeOfficial = "type_official"
        case level
        case numConnectors = "num_connectors"
    }
}
