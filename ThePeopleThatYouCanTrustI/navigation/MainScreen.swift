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
            if(networkMonitor.isConnected){
                VStack {
                    switch selection {
                    case .home:
                        HomeView()
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
                        }
                    }
                }
                .navigationTitle(selection.title)
                .toolbarColorScheme(.dark)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(Color(hex: "FF6200EE"), for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .overlay {
                    withAnimation(.bouncy) {
                        NavigationDrawer(sideBarRowType: $selection, isOpen: $isSideBarOpened)
                    }
                }
            } else {
                NoNetworkView()
            }
            
        }
    }
}
