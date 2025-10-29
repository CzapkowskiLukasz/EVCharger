//
//  SearchViewModel.swift
//  EVChargerr
//
//  Created by Łukasz on 15/10/2025.
//

import Foundation
import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    @Published var cities: [City] = []
    @Published var search: String = ""
    
    @Service var service: GeolocationServiceProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupBindings()
    }
    
    private func setupBindings() {
        $search
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .milliseconds(1000), scheduler: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                
                fetchCities(search: value)
                
            }
            .store(in: &cancellables)
    }
    
    private func fetchCities(search: String) {
        Task {
            do {
                cities = try await service.fetchCities(city: search)
            } catch {
                print(error)
            }
        }
    }
}
