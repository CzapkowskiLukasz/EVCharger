//
//  DefaultBottomSheet.swift
//  EVChargerr
//
//  Created by Łukasz on 11/10/2025.
//

import SwiftUI

struct DefaultBottomSheet<Content: View>: View {
    var content: Content
    
    @State private var offsetY: CGFloat = 0
    @State private var drawerHeight: CGFloat = 120
    @State private var startingOffset: CGFloat = UIScreen.main.bounds.height * 0.8
    @State private var currentOffset:CGFloat = 0
    @State private var endOffset:CGFloat = 0
    
    @State var drawerState: DrawerState = .collapsed
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Spacer()
                
                Capsule()
                    .frame(width: 40, height: 5)
                    .foregroundColor(.gray)
                    .padding(.top, 8)
                    .onTapGesture {
                        withAnimation {
                            drawerState = drawerState == .collapsed ? .expanded : .collapsed
                            drawerHeight = drawerState.drawerHeight
                            //drawerState = drawerState == .collapsed ? .expanded : .collapsed
                        }
                    }
                
                Spacer()
            }
            
            content
        }
        .clipped()
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(20)
        .offset(y:startingOffset)
        .offset(y:currentOffset)
        .offset(y:endOffset)
        .gesture(
            DragGesture()
                .onChanged{ value in
                    withAnimation(.spring()){
                        if currentOffset <= 0, drawerState == .collapsed {
                            currentOffset = max(value.translation.height, -DrawerState.expanded.drawerHeight)
                        } else if currentOffset >= 0, drawerState == .expanded {
                            currentOffset = min(value.translation.height, DrawerState.expanded.drawerHeight)
                        }
                        
                    }
                }
                .onEnded{ value in
                    withAnimation(.spring()){
                        if currentOffset < -150 {
                            drawerState = .expanded
                            endOffset = -DrawerState.expanded.drawerHeight
                        }else if endOffset != 0 && currentOffset > 150 {
                            drawerState = .collapsed
                            endOffset = .zero
                        }
                        currentOffset = 0
                    }
                }
        )
        .transition(.move(edge: .bottom))
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct BottomSheetModifier<SubView: View>: ViewModifier {
    @Binding var isShown: Bool
    
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
                withAnimation {
                    DefaultBottomSheet(content: subView)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

extension View {
    func selectedCharger(isShown: Binding<Bool>, charger: EVCharger?) -> some View {
        Group {
            if let charger = charger {
                self.modifier(BottomSheetModifier(isShown: isShown, subView: SelectedCharger(charger: charger)))
            } else {
                self
            }
        }
    }
}

// Stan szuflady
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
