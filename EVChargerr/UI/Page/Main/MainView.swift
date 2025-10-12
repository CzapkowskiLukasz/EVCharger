//
//  MainView.swift
//  EVChargerr
//
//  Created by Łukasz on 10/10/2025.
//
import SwiftUI
import MapKit

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        Group {
            switch viewModel.locationManager.authorizationStatus {
            case .notDetermined:
                Text("Proszę zezwolić na lokalizację")
                    .foregroundColor(.gray)
            case .restricted, .denied:
                Text("Brak dostępu do lokalizacji. Włącz w ustawieniach.")
                    .foregroundColor(.red)
            case .authorizedWhenInUse, .authorizedAlways:
                if let _ = viewModel.locationManager.userLocation {
                    Map(position: $viewModel.region, interactionModes: [.all]) {
                        
                        ForEach(viewModel.chargers) { charger in
                            Annotation(charger.name, coordinate: charger.coordinate) {
                                ChargerAnnotationView(
                                    charger: charger,
                                    isSelected: viewModel.selectedEvCharger?.id == charger.id,
                                    action: { charger in
                                        viewModel.selectCharger(charger: charger)
                                    })
                            }
                        }
                        
                        UserAnnotation()
                    }
                    .overlay(alignment: .bottomTrailing) {
                        Button(action: {
                            withAnimation(.easeInOut) {
                                viewModel.centerMapOnUserLocation()
                            }
                        }) {
                            Image(systemName: "scope") // nowa ikonka
                                .font(.title2)
                                .foregroundStyle(
                                    evGradient
                                )
                        }
                        .buttonStyle(.capsule)
                        .padding()
                        
                    }
                    .edgesIgnoringSafeArea(.all)
                } else {
                    ProgressView("Ładowanie lokalizacji...")
                }
            @unknown default:
                Text("Nieznany status lokalizacji")
            }
            
        }
        .selectedCharger(isShown: $viewModel.isSheetShown, charger: viewModel.selectedEvCharger)
    }
    
}

#Preview {
    MainView()
}
