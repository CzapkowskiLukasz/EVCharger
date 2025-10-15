//
//  SearchView.swift
//  EVChargerr
//
//  Created by Łukasz on 15/10/2025.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    
    var action: (City) -> Void
    
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.search)
            
            Divider()
            
            ScrollView {
                VStack {
                    ForEach(viewModel.cities) { city in
                        CityView(viewModel: .init(city: city))
                            .onTapGesture {
                                action(city)
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    SearchView(viewModel: .init(), action: { _ in })
}
