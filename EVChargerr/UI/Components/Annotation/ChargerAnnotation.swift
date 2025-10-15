//
//  ChargerAnnotation.swift
//  EVChargerr
//
//  Created by Łukasz on 12/10/2025.
//

import SwiftUI
import MapKit

struct ChargerAnnotationView: View {
    @State private var pulse: Bool = false
    
    let charger: EVCharger
    let isSelected: Bool
    let action: (EVCharger) -> Void
    
    var body: some View {
            ZStack {
                Circle()
                    .fill(Color.yellow.opacity(0.3))
                    .frame(width: 45, height: 45)
                    .scaleEffect(isSelected && pulse ? 1.3 : 1.0)
                    .blur(radius: isSelected ? 15 : 0)
                    .opacity(isSelected ? 1 : 0)
                    .animation(
                        isSelected
                            ? .easeInOut(duration: 1.2).repeatForever(autoreverses: true)
                            : .default,
                        value: isSelected
                    )
                    .onChange(of: isSelected) { selected in
                        pulse = selected
                    }

                Image(systemName: "bolt.circle.fill")
                    .font(.title)
                    .foregroundColor(isSelected ? .yellow : .green)
                    .shadow(
                        color: isSelected ? .yellow.opacity(0.8) : .clear,
                        radius: isSelected ? 10 : 0
                    )
                    .onTapGesture {
                        withAnimation(.spring()) {
                            action(charger)
                        }
                    }
            }
        }
}
