//
//  CircleButtonStyle.swift
//  EVChargerr
//
//  Created by Łukasz on 13/10/2025.
//

import SwiftUI

struct CircleButtonStyle: ButtonStyle {
    var style: EVButtonType
    
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .colorForeground(apply: style == .primary)
            .buttonBorderShape(.circle)
            .padding()
            .background(
                getBackground()
            )
            .overlay(
                Capsule()
                    .stroke(evGradient, lineWidth: 1.5)
                    .opacity(0.9)
            )
            .foregroundStyle(evGradient)
            .gradientForeground(apply: style == .outline)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
    
    @ViewBuilder
    func getBackground() -> some View {
        if style == .primary {
            Capsule().fill(evGradient)
        } else {
            Capsule().fill(Color(.systemBackground))
        }
    }

}

struct ConditionalForegroundGradient: ViewModifier {
    let apply: Bool
    
    func body(content: Content) -> some View {
        if apply {
            content.foregroundStyle(evGradient)
        } else {
            content
        }
    }
}

struct ConditionalForegroundColor: ViewModifier {
    let apply: Bool
    
    func body(content: Content) -> some View {
        if apply {
            content.foregroundColor(Color(.systemBackground))
        } else {
            content
        }
    }
}

extension View {
    func gradientForeground(apply: Bool) -> some View {
        self.modifier(
            ConditionalForegroundGradient(apply: apply)
        )
    }
    
    func colorForeground(apply: Bool) -> some View {
        self.modifier(
            ConditionalForegroundColor(apply: apply)
        )
    }
}


extension ButtonStyle where Self == CircleButtonStyle {
    static var primaryRound: CircleButtonStyle { CircleButtonStyle(style: .primary) }
    static var outlineRound: CircleButtonStyle { CircleButtonStyle(style: .outline) }
}
