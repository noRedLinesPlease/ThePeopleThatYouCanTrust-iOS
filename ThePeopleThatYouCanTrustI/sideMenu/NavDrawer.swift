//
//  NavDrawer.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/25/24.
//

import SwiftUI

struct NavigationDrawer: View {
    @Injection(\.navigationManager) var navigationManager
    @Binding var sideBarRowType: SideBarRowType
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.6
    var sideBarHeight = UIScreen.main.bounds.size.height * 0.1
    
    
    @Binding var isOpen: Bool
    
    var body: some View {
        ZStack {
            Color.clear
                .background(isOpen ? .black.opacity(0.5) : .black.opacity(0.0))
                .opacity(isOpen ? 1 : 0)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    if(isOpen){
                        isOpen.toggle()
                    }
                }
            VStack {
                if(isOpen) {
                    HStack {
                        SideBarView(
                            selectedSideMenuTab: $sideBarRowType,
                            isSidebarVisible: $isOpen,
                            navigationManager: navigationManager as! NavigationManager
                        )
                        .padding(.top, 40)
                        .offset(
                            x: isOpen ? -40 : -sideBarWidth,
                            y: isOpen ? -40 : -sideBarHeight
                        )
                    }

                }
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
        }                 

    }
}


