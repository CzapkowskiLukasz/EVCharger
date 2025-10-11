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
                if let userLoc = viewModel.locationManager.userLocation {
                    Map(position: $viewModel.region) {
                        
                        ForEach(viewModel.chargers) { charger in
                            Annotation(charger.name, coordinate: charger.coordinate) {
                                Image(systemName: "bolt.circle.fill")
                                                .font(.title)
                                                .foregroundColor(.green)
                                                .onTapGesture {
                                                    viewModel.selectCharger(charger: charger)
                                                }
                            }
                        }
                        
                        UserAnnotation()
                    }
//                    {
//                        // Map pins
//                        ForEach(viewModel.charges) { charger in
//                            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: charger.latitude, longitude: charger.longitude)) {
//                                VStack {
//                                    Image(systemName: "bolt.circle.fill")
//                                        .font(.title)
//                                        .foregroundColor(.green)
//                                    Text(charger.station_name)
//                                        .font(.caption)
//                                        .background(Color.white.opacity(0.7))
//                                        .cornerRadius(6)
//                                }
//                            }
//                        }
//                    }
//                    .onAppear {
//                        //region.center = userLoc
//                        viewModel.loadChargers()
//                    }
                    //                        .onChange(of: locationManager.userLocation.map { ($0.latitude, $0.longitude) }) { newValue in
                    //                            if let newValue = newValue {
                    //                                region.center = CLLocationCoordinate2D(latitude: newValue.0, longitude: newValue.1)
                    //                            }
                    //                        }
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
