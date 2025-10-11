//
//  ConnectionView.swift
//  EVChargerr
//
//  Created by Łukasz on 10/10/2025.
//

import SwiftUI

struct ConnectionView: View {
    let connection: EVConnection
    
    var body: some View {
        HStack(spacing: 15) {
            Text("⚡") // ikona mocy
                .font(.largeTitle)
                .padding(10)
                .background(Color.green.opacity(0.2))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text("🔌 \(connection.typeName)")
                    .font(.headline)
                Text("🏷️ Oficjalny: \(connection.typeOfficial)")
                    .font(.caption)
                    .foregroundColor(.black)
                Text("⚡ Poziom: \(connection.level)")
                    .font(.caption2)
                    .foregroundColor(.black)
                Text("🔢 Liczba konektorów: \(connection.numConnectors)")
                    .font(.caption)
                    .foregroundColor(.black)
            }
            
            Spacer()
        }
        .background(Color.white.opacity(0.95))
        .cornerRadius(12)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.purple, Color.blue, Color.green]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1.5
                )
                .opacity(0.9)
        )
        .padding(.horizontal, 16)
    }
}
