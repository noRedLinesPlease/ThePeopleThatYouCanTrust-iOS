//
//  MainScreen.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/10/24.
//

import SwiftUI

struct MainScreen: View {
    @Injection(\.navigationManager) var navigationManager
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    @State var selection: SideBarRowType = .companies
    @State var selectedSideMenuTab = 0
    @State var isSideBarOpened = false
    
    var body: some View {
        NavigationView {
            VStack {
                switch selection {
                case .aboutUs:
                    AboutUsView()
                case .companies:
                    CompaniesView()
                case .shareApp:
                    ShareAppView()
                }
            }
            .onReceive(navigationManager.pageSelection) { newValue in
                selection = newValue
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isSideBarOpened.toggle()
                    } label: {
                        Label("Toggle", systemImage: "line.3.horizontal")
                    }.tint(Color.blue)
                }
            }
            .toolbarBackground(Color.gray.opacity(0.40))
            .toolbarBackground(.visible, for: .navigationBar)
            .overlay {
                withAnimation(.bouncy) {
                    NavigationDrawer(sideBarRowType: $selection, isOpen: $isSideBarOpened)
                }
            }
        }
    }
}

