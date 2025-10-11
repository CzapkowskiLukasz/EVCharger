//
//  Button.swift
//  EVChargerr
//
//  Created by Łukasz on 11/10/2025.
//

import SwiftUI

enum EVButtonType {
    case primary
    case outline
    
    var background: Color {
        switch self {
        case .primary:
            Color.black
        case .outline:
            Color.white
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .primary:
            Color.black
        case .outline:
            Color.black
        }
    }
}

struct EVButtonStyle: ButtonStyle {
    var style: EVButtonType
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(style.foregroundColor)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(style.background)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
            )
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == EVButtonStyle {
    static var primary: EVButtonStyle { EVButtonStyle(style: .primary) }
    static var outline: EVButtonStyle { EVButtonStyle(style: .outline) }
}
