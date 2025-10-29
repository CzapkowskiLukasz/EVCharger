//
//  DI.swift
//  EVChargerr
//
//  Created by Łukasz on 29/10/2025.
//
import Foundation
import Swinject

enum AppDi {
    static func configure() {
        Service.configure()
    }
}

extension AppDi {
    enum Service {
        static func configure () {
            DI.container.register(
                EVChargerServiceProtocol.self,
                factory: { _ in EVChargerService() }
            )
            .inObjectScope(.container)
            
            DI.container.register(
                GeolocationServiceProtocol.self,
                factory: { _ in GeolocationService() }
            )
            .inObjectScope(.container)
            
            DI.container.register(
                CountryServiceProtocol.self,
                factory: { _ in CountryService() }
            )
            .inObjectScope(.container)
        }
    }
}

enum DI {
    static let container = Container()
}
