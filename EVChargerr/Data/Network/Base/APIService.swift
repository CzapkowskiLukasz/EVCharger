//
//  ApiService.swift
//  EVChargerr
//
//  Created by Łukasz on 11/10/2025.
//

import Foundation

protocol APIService {
    var apiKey: String { get }
    var base: String { get }
    
    func fetch<T: Decodable>(
        endpoint: String,
        queryItems: [URLQueryItem]
    ) async throws -> T
}

extension APIService {
    
    var apiKey: String { "" }
    
    @MainActor
    func fetch<T: Decodable>(
        endpoint: String,
        queryItems: [URLQueryItem] = []
    ) async throws -> T {
        guard var components = URLComponents(string: endpoint) else {
            throw URLError(.badURL)
        }

        components.queryItems = queryItems

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse,
              (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
