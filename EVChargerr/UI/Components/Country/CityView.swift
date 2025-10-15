//
//  CountryView.swift
//  EVChargerr
//
//  Created by Łukasz on 15/10/2025.
//

import SwiftUI
import Kingfisher

struct CityView: View {
    @StateObject var viewModel: CityViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            
            // Flaga
            Text(viewModel.flag ?? "🏳️")
                .font(.largeTitle)
            
            // Miasto i kraj
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.city.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(viewModel.countryName ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemGray6))
        )
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }
}

#Preview {
    CityView(
        viewModel: .init(
            city: .init(name: "Warsaw", latitude: 0, longitude: 0, country: "PL")
        )
    )
}
