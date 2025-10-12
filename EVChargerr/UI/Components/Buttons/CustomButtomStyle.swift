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
    case navigation
    case capsule

    var background: Color {
        switch self {
        case .primary:
            Color.black
        case .outline:
            Color.white
        case .navigation:
            Color.blue
        case .capsule:
            Color.white
        }
    }

    var foregroundColor: Color {
        switch self {
        case .primary, .outline:
            Color.black
        case .navigation, .capsule:
            Color.white
        }
    }
}

struct EVButtonStyle: ButtonStyle {
    var style: EVButtonType
    var cornerRadius: CGFloat = 12

    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .buttonBorderShape(style == .capsule ? .circle : .automatic)
            .foregroundColor(style.foregroundColor)
            .padding()
            .background(
                Group {
                    switch style {
                    case .capsule:
                        Capsule()
                            .fill(style.background)
                    default:
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(style.background)
                            .overlay(
                                RoundedRectangle(cornerRadius: cornerRadius)
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                            )
                    }
                }
            )
            .overlay(
                Group {
                    if style == .capsule {
                        Capsule()
                            .stroke(evGradient, lineWidth: 1.5)
                            .opacity(0.9)
                    }
                }
            )
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }

}

extension ButtonStyle where Self == EVButtonStyle {
    static var primary: EVButtonStyle { EVButtonStyle(style: .primary) }
    static var outline: EVButtonStyle { EVButtonStyle(style: .outline) }
    static var navigation: EVButtonStyle { EVButtonStyle(style: .navigation) }
    static var capsule: EVButtonStyle { EVButtonStyle(style: .capsule) }
}
