//
//  SelectedCharger.swift
//  EVChargerr
//
//  Created by Łukasz on 10/10/2025.
//

import SwiftUI

struct SelectedCharger: View {
    var charger: EVCharger
    var viewModel: SelectedChargerModel = .init()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            VStack(alignment: .leading, spacing: 4) {
                Text(charger.name)
                    .font(.title3.bold())
                Text("\(charger.address), \(charger.city)")
                    .font(.subheadline)
            }
            .padding(.horizontal)
            .padding(.top)
            
            Divider()
            
            Text("Złącza")
                .font(.headline)
                .padding(.horizontal)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 8) {
                    
                    if charger.connections.isEmpty {
                        Text("Brak złączy")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                    } else {
                        ForEach(charger.connections, id: \.typeName) { connection in
                            ConnectionView(connection: connection)
                        }
                    }
                    
                    Button(action: { viewModel.openInMaps(charger: charger) }) {
                        HStack {
                            Image(systemName: "map.fill")
                                .font(.title2)
                            Text("Nawiguj w Mapach")
                                .font(.headline)
                                .fontWeight(.semibold)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            Color(UIColor { trait in
                                trait.userInterfaceStyle == .dark ?
                                UIColor.systemBlue.withAlphaComponent(0.3) :
                                UIColor.systemBlue.withAlphaComponent(0.1)
                            })
                        )
                        .cornerRadius(10)
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: { viewModel.openInGoogleMaps(charger: charger) }) {
                        HStack {
                            Image("google_maps_icon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 24)
                            Text("Nawiguj w Google Maps")
                                .font(.headline)
                                .fontWeight(.semibold)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                                Color(UIColor { trait in
                                    trait.userInterfaceStyle == .dark ?
                                    UIColor.systemGreen.withAlphaComponent(0.3) :
                                    UIColor.systemGreen.withAlphaComponent(0.1)
                                })
                            )
                        .cornerRadius(10)
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 16)
                    
                }
                .padding(.vertical, 8)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                .background(Color(.systemBackground))
            }
            .clipped()
            .frame(height: DrawerState.expanded.drawerHeight)
            .background(Color(.systemBackground))
            
            Spacer()
        }
        .background(Color(.systemBackground))
    }
}
