//
//  GeolocationService.swift
//  EVChargerr
//
//  Created by Łukasz on 15/10/2025.
//

import Foundation

class GeolocationService: GeolocationServiceProtocol {

    func fetchCities(
        city: String
    ) async throws -> [City] {
        
        let queryItems: [URLQueryItem] = [
                    URLQueryItem(name: "city", value: "\(city)")
                ]
        
        return try await fetch(endpoint: base + "geocoding", queryItems: queryItems)
        
    }
}
