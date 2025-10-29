//
//  GeolocationServiceProtocol.swift
//  EVChargerr
//
//  Created by Łukasz on 29/10/2025.
//

import Foundation

protocol GeolocationServiceProtocol: ApiNinjasBase {
    func fetchCities(
        city: String
    ) async throws -> [City]
}
