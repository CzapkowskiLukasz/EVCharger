//
//  DefaultBottomSheet.swift
//  EVChargerr
//
//  Created by Łukasz on 11/10/2025.
//

import SwiftUI

struct DefaultBottomSheet<Content: View>: View {
    
    @State var drawerState: DrawerState = .collapsed
    @State private var offsetY: CGFloat = 0
    @State private var drawerHeight: CGFloat = 120
    @State private var startingOffset: CGFloat = UIScreen.main.bounds.height * 0.8
    @State private var currentOffset: CGFloat = 0
    @State private var endOffset: CGFloat = 0
    
    var content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // uchwyt
            HStack {
                Spacer()
                Capsule()
                    .frame(width: 40, height: 5)
                    .foregroundColor(.gray)
                    .padding(.top, 8)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            drawerState = drawerState == .collapsed ? .expanded : .collapsed
                            drawerHeight = drawerState.drawerHeight
                        }
                    }
                Spacer()
            }
            
            content
                .frame(maxHeight: .infinity)
                .clipped()
        }
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(radius: 10)
        .offset(y: startingOffset + currentOffset + endOffset)
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation(.spring()) {
                        if currentOffset <= 0, drawerState == .collapsed {
                            currentOffset = max(value.translation.height, -DrawerState.expanded.drawerHeight)
                        } else if currentOffset >= 0, drawerState == .expanded {
                            currentOffset = min(value.translation.height, DrawerState.expanded.drawerHeight)
                        }
                    }
                }
                .onEnded { _ in
                    withAnimation(.spring()) {
                        if currentOffset < -150 {
                            drawerState = .expanded
                            endOffset = -DrawerState.expanded.drawerHeight
                        } else if endOffset != 0 && currentOffset > 150 {
                            drawerState = .collapsed
                            endOffset = 0
                        }
                        currentOffset = 0
                    }
                }
        )
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            if drawerState == .expanded {
                withAnimation (.spring()) {
                    endOffset = -DrawerState.expanded.drawerHeight
                }
            }
        }
    }
}


struct BottomSheetModifier<SubView: View>: ViewModifier {
    @Binding var isShown: Bool
    
    var state: DrawerState = .collapsed
    var subView: SubView
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
                .onTapGesture {
                    withAnimation {
                        isShown = false
                    }
                }
            
            if isShown {
                DefaultBottomSheet(drawerState: state, content: subView)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .animation(.spring(), value: isShown)
            }
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

extension View {
    func selectedCharger(isShown: Binding<Bool>, charger: EVCharger?) -> some View {
        self.modifier(
            BottomSheetModifier(
                isShown: isShown,
                subView: charger.map { SelectedCharger(charger: $0) }
            )
        )
    }
    
    func searchSheet(isShown: Binding<Bool>, state: DrawerState = .collapsed, action: @escaping (City) -> Void) -> some View {
        self.modifier(
            BottomSheetModifier(
                isShown: isShown,
                state: state,
                subView: SearchView(viewModel: .init(), action: action)
            )
        )
    }
}

enum DrawerState {
    case collapsed
    case expanded
    
    var drawerHeight: CGFloat {
        switch self {
        case .collapsed: return 120
        case .expanded: return UIScreen.main.bounds.height * 0.6
        }
    }
}
