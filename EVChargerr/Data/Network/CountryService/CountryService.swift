//
//  CountryService.swift
//  EVChargerr
//
//  Created by Łukasz on 15/10/2025.
//

import Foundation

class CountryService: CountryServiceProtocol {
    
    var base: String = "https://restcountries.com/v3.1/alpha/"
    
    func fetchFlags(
        countryCode: String
    ) async throws -> [Country] {
        
        return try await fetch(endpoint: base + countryCode)
        
    }
}
