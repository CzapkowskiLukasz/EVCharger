//
//  Slider.swift
//  EVChargerr
//
//  Created by Łukasz on 29/10/2025.
//

import Foundation
import SwiftUI

struct SliderView: View {
    @State private var value: Double = 5

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Wybrana wartość")
                .font(.headline)

            HStack {
                Slider(
                    value: $value,
                    in: 5...25,
                    step: 1
                )
                .accentColor(.blue)
                .padding()
                
                Text("\(Int(value)) km")
            }
        }
        .padding()
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView()
    }
}
