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
    
    @State private var contentHeight: CGFloat = .zero
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Group {
                Text(charger.name)
                    .font(.headline)
                Text("\(charger.address), \(charger.city)")
                    .font(.subheadline)
            }
            .padding()
            
            Divider()
            
            Text("Złącza:")
                .font(.headline)
                .padding(.horizontal)
            
            // ScrollView z dynamiczną wysokością
            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    ForEach(charger.connections, id: \.typeName) { connection in
                        ConnectionView(connection: connection)
                    }
                    
                    VStack {
                        Button(action: { viewModel.openInMaps(charger: charger) }) {
                            HStack {
                                Image(systemName: "car.fill")
                                Text("Nawiguj").bold()
                            }
                        }
                        .buttonStyle(.primary)
                        
                        Button(action: { viewModel.openInGoogleMaps(charger: charger) }) {
                            HStack {
                                Image(systemName: "map.fill")
                                Text("Nawiguj (Google Maps)").bold()
                            }
                        }
                        .buttonStyle(.primary)
                    }
                    .padding(.horizontal, 16)
                }
                // Pomiar wysokości zawartości
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .preference(key: HeightPreferenceKey.self, value: geo.size.height)
                    }
                )
            }
            .frame(maxHeight: contentHeight) // ScrollView ograniczona do zawartości
            .onPreferenceChange(HeightPreferenceKey.self) { newHeight in
                self.contentHeight = newHeight
            }
        }
        .background(Color.white)
        .foregroundColor(.black)
    }
}

// PreferenceKey do pomiaru wysokości
struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
