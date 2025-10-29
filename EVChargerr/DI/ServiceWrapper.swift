//
//  ServiceWrapper.swift
//  EVChargerr
//
//  Created by Łukasz on 29/10/2025.
//

@propertyWrapper
struct Service<T> {
    private var service: T

    init() {
        guard let resolved = DI.container.resolve(T.self) else {
            fatalError("Nie znaleziono zależności dla typu \(T.self)")
        }
        self.service = resolved
    }

    var wrappedValue: T {
        service
    }
}
