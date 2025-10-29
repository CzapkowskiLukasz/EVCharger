//
//  EVChargerrApp.swift
//  EVChargerr
//
//  Created by Łukasz on 10/10/2025.
//

import SwiftUI

@main
struct EVChargerrApp: App {
    init() {
        AppDi.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
