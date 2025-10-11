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
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var region: MapCameraPosition = .region( MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.4277, longitude: -122.1701),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    ) )
    
    @Published var selectedEvCharger: EVCharger?
    @Published var isSheetShown: Bool = false
    
    private let service = EVChargerService()
    let locationManager = LocationManager()
    
    init() {
        userLocation = locationManager.userLocation
        
        if let userLocation = userLocation {
            region = .region(MKCoordinateRegion(center: userLocation , span: .init(latitudeDelta: 0.05, longitudeDelta: 0.05)))
        }
        
        // Obserwacja zmian lokalizacji
        locationManager.$userLocation
            .debounce(for: .milliseconds(1000), scheduler: DispatchQueue.main)
            .sink { [weak self] newLoc in
                guard let self = self else { return }
                
                self.userLocation = newLoc
                
                if let userLocation = userLocation {
                    region = .region(MKCoordinateRegion(center: userLocation , span: .init(latitudeDelta: 0.05, longitudeDelta: 0.05)))
                }
                
                self.loadChargers(userLocation: newLoc)
                
            }
            .store(in: &cancellables)
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func loadChargers(userLocation: CLLocationCoordinate2D?) {
        guard let userLocation = userLocation else { return }
        
        Task {
            do {
                chargers = try await service.fetchChargers(lat: userLocation.latitude, lon: userLocation.longitude, distance: 20)
            } catch {
                //self.error = error.localizedDescription
            }
        }
    }
    
    func selectCharger(charger: EVCharger) {
        withAnimation {
            selectedEvCharger = charger
            region = .region(MKCoordinateRegion(center: charger.coordinate , span: .init(latitudeDelta: 0.05, longitudeDelta: 0.05)))
            isSheetShown = true
        }
    }
}
