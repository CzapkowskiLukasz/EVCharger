//
//  View + readSize.swift
//  EVChargerr
//
//  Created by Łukasz on 11/10/2025.
//

import SwiftUI

extension View {
    
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        
        background(
            GeometryReader { geometry in
                Color.clear
                    .preference(
                        key: SizePreferenceKey.self,
                        value: geometry.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self) { newSize in
            DispatchQueue.main.async {
                onChange(newSize)
            }
        }
        
    }
    
}

private struct SizePreferenceKey: PreferenceKey {
    
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {  }
    
}
