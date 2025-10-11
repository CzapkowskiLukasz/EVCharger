//
//  Untitled.swift
//  EVChargerr
//
//  Created by Łukasz on 10/10/2025.
//

import SwiftUI
import MapKit

class SelectedChargerModel: ObservableObject {
    func openInMaps(charger: EVCharger) {
        let coordinate = charger.coordinate
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = charger.name
        mapItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }
    
    func openInGoogleMaps(charger: EVCharger) {
        let destination = "\(charger.address), \(charger.city)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        if let url = URL(string: "comgooglemaps://?daddr=\(destination)&directionsmode=driving"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else if let browserUrl = URL(string: "https://www.google.com/maps/dir/?api=1&destination=\(destination)") {
            UIApplication.shared.open(browserUrl)
        }
    }
}
