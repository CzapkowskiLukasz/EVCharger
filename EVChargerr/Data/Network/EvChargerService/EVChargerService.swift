//
//  Untitled.swift
//  EVChargerr
//
//  Created by Łukasz on 10/10/2025.
//

import Foundation

class EVChargerService: APIService {
    var apiKey: String
    
    init() {
        self.apiKey = ProcessInfo.processInfo.environment["API_KEY"] ?? ""
    }
    

    func fetchChargers(
        lat: Double,
        lon: Double,
        distance: Double? = nil
    ) async throws -> [EVCharger] {
        
        var queryItems: [URLQueryItem] = [
                    URLQueryItem(name: "lat", value: "\(lat)"),
                    URLQueryItem(name: "lon", value: "\(lon)")
                ]
        
                if let distance = distance {
                    queryItems.append(URLQueryItem(name: "distance", value: "\(distance)"))
                }
        
        return try await fetch(endpoint: "https://api.api-ninjas.com/v1/evcharger", queryItems: queryItems)
        
    }
}
