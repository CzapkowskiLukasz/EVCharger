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
                .background(
                    Color(UIColor { trait in
                        switch trait.userInterfaceStyle {
                        case .dark:
                            // mocniejsze tło w Dark Mode
                            return UIColor.systemGreen.withAlphaComponent(0.6)
                        default:
                            // delikatniejsze tło w Light Mode
                            return UIColor.systemGreen.withAlphaComponent(0.2)
                        }
                    })
                )
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text("🔌 \(connection.typeName)")
                    .font(.headline)
                Text("🏷️ Oficjalny: \(connection.typeOfficial)")
                    .font(.caption)
                Text("⚡ Poziom: \(connection.level)")
                    .font(.caption2)
                Text("🔢 Liczba konektorów: \(connection.numConnectors)")
                    .font(.caption)
            }
            
            Spacer()
        }
        .background(Color(.systemBackground).opacity(0.95))
        .cornerRadius(12)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    evGradient,
                    lineWidth: 1.5
                )
                .opacity(0.9)
        )
    }
}
