//
//  Untitled.swift
//  EVChargerr
//
//  Created by Łukasz on 10/10/2025.
//

import Foundation

final class EVChargerService {
    private var apiKey: String {
        // Pobieramy z environment variables
        guard let key = ProcessInfo.processInfo.environment["API_KEY"] else {
            fatalError("Nie znaleziono API key w environment variables")
        }
        return key
    }

    func fetchChargers(
        lat: Double,
        lon: Double,
        distance: Double? = nil,
        network: String? = nil,
        minPowerKW: Double? = nil
    ) async throws -> [EVCharger] {

        var components = URLComponents(string: "https://api.api-ninjas.com/v1/evcharger")!
        
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "lat", value: "\(lat)"),
            URLQueryItem(name: "lon", value: "\(lon)")
        ]
        
        if let distance = distance {
            queryItems.append(URLQueryItem(name: "distance", value: "\(distance)"))
        }
        
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([EVCharger].self, from: data)
    }
}
