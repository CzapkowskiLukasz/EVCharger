//
//  SearchView.swift
//  EVChargerr
//
//  Created by Łukasz on 15/10/2025.
//

import SwiftUI

enum SearchMode {
    case expanded
    case collapsed
    
    func toggle() -> SearchMode {
        switch self {
        case .expanded:
            return .collapsed
        case .collapsed:
            return .expanded
        }
    }
}

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    @State var mode: SearchMode = .collapsed
    
    var action: (City) -> Void
    
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.search)
            
            SliderView()
                .frame(height: mode == .collapsed ? 0 : nil, alignment: .top)
                .clipped()
            
                Button(action: {
                    withAnimation(.spring()) {
                        mode = mode.toggle()
                    }
                }) {
                    HStack{
                        Text(mode == .expanded ? "Ukryj dodatkowe opcje" : "Pokaż dodatkowe opcje")
                            .foregroundColor(.blue)
                        Image(systemName: mode == .expanded ? "chevron.up" : "chevron.down")
                            .renderingMode(.template)
                            .foregroundColor(.blue)
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .padding(.vertical, 4)
                }
                .buttonStyle(PlainButtonStyle())
            
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
