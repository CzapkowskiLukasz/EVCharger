//
//  ApiNinjasBase.swift
//  EVChargerr
//
//  Created by Łukasz on 29/10/2025.
//
import Foundation

protocol ApiNinjasBase: APIService {
    var base: String { get }
    var apiKey: String { get }
}

extension ApiNinjasBase {
    var base: String { "https://api.api-ninjas.com/v1/" }
    var apiKey: String { ProcessInfo.processInfo.environment["API_KEY"] ?? "" }
}
