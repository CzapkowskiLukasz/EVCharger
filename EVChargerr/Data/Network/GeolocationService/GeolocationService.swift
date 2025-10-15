//
//  GeolocationService.swift
//  EVChargerr
//
//  Created by Łukasz on 15/10/2025.
//

import Foundation

class GeolocationService: APIService {
    var apiKey: String
    
    init() {
        self.apiKey = ProcessInfo.processInfo.environment["API_KEY"] ?? ""
    }
    

    func fetchCities(
        city: String
    ) async throws -> [City] {
        
        let queryItems: [URLQueryItem] = [
                    URLQueryItem(name: "city", value: "\(city)")
                ]
        
        return try await fetch(endpoint: base + "geocoding", queryItems: queryItems)
        
    }
}
