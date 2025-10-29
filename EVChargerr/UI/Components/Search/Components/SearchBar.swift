//
//  SearchBar.swift
//  EVChargerr
//
//  Created by Łukasz on 15/10/2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                //.foregroundColor(.gray)
                .foregroundStyle(evGradient)
            
            TextField("Szukaj...", text: $text)
                .padding(8)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .transition(.opacity)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(
            Capsule()
                .fill(Color(.systemGray6))
                .stroke(evGradient, lineWidth: 1)
        )
        .animation(.easeInOut(duration: 0.2), value: text)
        .padding()
    }
}

#Preview {
    SearchBar(text: .constant(""))
}
