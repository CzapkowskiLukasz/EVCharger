//
//  EVChargerServiceProtocol.swift
//  EVChargerr
//
//  Created by Łukasz on 29/10/2025.
//

import Foundation

protocol EVChargerServiceProtocol: ApiNinjasBase {
    func fetchChargers(
        lat: Double,
        lon: Double,
        distance: Double?
    ) async throws -> [EVCharger]
}

extension EVChargerServiceProtocol {
    func fetchChargers(
        lat: Double,
        lon: Double,
        distance: Double? = nil
    ) async throws -> [EVCharger] {
        try await fetchChargers(lat: lat, lon: lon, distance: distance)
    }
}
