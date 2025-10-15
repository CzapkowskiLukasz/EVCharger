//
//  CountryService.swift
//  EVChargerr
//
//  Created by Łukasz on 15/10/2025.
//

import Foundation

class CountryService: APIService {
    func fetchFlags(
        countryCode: String
    ) async throws -> [Country] {
        
        return try await fetch(endpoint: "https://restcountries.com/v3.1/alpha/\(countryCode)")
        
    }
}
