//
//  CountryViewModel.swift
//  EVChargerr
//
//  Created by Łukasz on 15/10/2025.
//

import Foundation

class CityViewModel: ObservableObject {
    private let service = CountryService()
    
    var city: City
    @Published var flagUrl: String?
    @Published var flag: String?
    @Published var countryName: String?
    
    init(city: City) {
        self.city = city
        
        getInfo()
    }
    
    func flagEmoji() -> String {
        city.country
            .uppercased()
            .unicodeScalars
            .compactMap { UnicodeScalar(127397 + $0.value) }
            .map { String($0) }
            .joined()
    }
    
    func getInfo() {
        Task {
            do {
                var info = try await service.fetchFlags(countryCode: city.country)
                if let country = info.first {
                    DispatchQueue.main.async {
                        self.flag = country.flag
                        self.flagUrl = country.flags.png
                        self.countryName = country.name.common
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}
