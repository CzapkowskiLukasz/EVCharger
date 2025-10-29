//
//  CountryServiceProtocol.swift
//  EVChargerr
//
//  Created by Łukasz on 29/10/2025.
//

import Foundation

protocol CountryServiceProtocol: APIService {
    func fetchFlags(
        countryCode: String
    ) async throws -> [Country]
}
