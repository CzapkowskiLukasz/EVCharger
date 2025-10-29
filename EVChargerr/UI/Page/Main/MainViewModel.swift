//
//  MainViewModel.swift
//  EVChargerr
//
//  Created by Łukasz on 10/10/2025.
//

import Foundation
import Combine
import CoreLocation
import MapKit
import _MapKit_SwiftUI
import SwiftUI

final class MainViewModel: ObservableObject {
    @Published var chargers: [EVCharger] = []
    @Published var region: MapCameraPosition = .userLocation(
        followsHeading: true,
        fallback: .region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 37.4277, longitude: -122.1701),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        )
    )
    
    @Published var selectedEvCharger: EVCharger?
    @Published var isSheetShown: Bool = false
    @Published var shearchActive: Bool = false
    @Published var searchText: String = ""
    
    var manageMapChange: Bool = false
    var manageCameraFollow: Bool = true
    
    private var lastCenterCoordinate: CLLocationCoordinate2D?
    private var lastLoadLocation: CLLocationCoordinate2D?
    private let loadDistanceThreshold: Double = 500
    @Service var service: EVChargerServiceProtocol
    let locationManager = LocationManager()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupBindings()
    }
    
    private func setupBindings() {
        locationManager.$userLocation
            .debounce(for: .milliseconds(1000), scheduler: DispatchQueue.main)
            .sink { [weak self] newLoc in
                guard let self = self, let userLocation = newLoc else { return }
                
                if let last = self.lastLoadLocation {
                    let distance = CLLocation(latitude: last.latitude, longitude: last.longitude)
                        .distance(from: CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude))
                    
                    if distance >= 10 {
                        if self.manageCameraFollow {
                            withAnimation {
                                self.region = .userLocation(
                                    followsHeading: false,
                                    fallback: .region(
                                        MKCoordinateRegion(
                                            center: userLocation,
                                            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                        )
                                    )
                                )
                            }
                        }
                    }
                    
                    if distance >= self.loadDistanceThreshold {
                        self.loadChargers(userLocation: userLocation)
                        self.lastLoadLocation = userLocation
                    }
                } else {
                    self.region = .userLocation(
                        followsHeading: false,
                        fallback: .region(
                            MKCoordinateRegion(
                                center: userLocation,
                                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                            )
                        )
                    )
                    self.manageMapChange = true
                    self.manageCameraFollow = true
                    self.loadChargers(userLocation: userLocation)
                    self.lastCenterCoordinate = userLocation
                    self.lastLoadLocation = userLocation
                }
            }
            .store(in: &cancellables)
        
        $region
            .removeDuplicates()
            .dropFirst()
            .sink { [weak self] newRegion in
                guard let self = self else { return }
                
                if self.manageMapChange {
                    self.manageCameraFollow = false
                }
                
            }
            .store(in: &cancellables)
        
        $isSheetShown
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] value in
                guard let self else { return }
                
                if !value {
                    self.selectedEvCharger = nil
                }
            }
            .store(in: &cancellables)
    }
    
    func loadChargers(userLocation: CLLocationCoordinate2D?) {
        guard let userLocation = userLocation else { return }
        
        fetchChargers(lat: userLocation.latitude, lon: userLocation.longitude)
    }
    
    func selectCharger(charger: EVCharger) {
        withAnimation {
            shearchActive = false
            selectedEvCharger = charger
            region = .region(
                MKCoordinateRegion(
                    center: charger.coordinate,
                    span: .init(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
            )
        }
        isSheetShown = true
    }
    
    func selectCity(city: City) {
        withAnimation {
            shearchActive = false
            region = .region(
                MKCoordinateRegion(
                    center: .init(latitude: city.latitude, longitude: city.longitude),
                    span: .init(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
            )
            
            fetchChargers(lat: city.latitude, lon: city.longitude)
        }
        isSheetShown = true
    }
    
    func centerMapOnUserLocation() {
        if let userLocation = locationManager.userLocation {
            manageCameraFollow = true
            self.region = .userLocation(
                followsHeading: false,
                fallback: .region(
                    MKCoordinateRegion(
                        center: userLocation,
                        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    )
                )
            )
        }
    }
    
    private func fetchChargers(lat: Double, lon: Double) {
        Task {
            do {
                chargers = try await service.fetchChargers(
                    lat: lat,
                    lon: lon,
                    distance: 20
                )
            } catch {
                print(error)
            }
        }
    }
}
