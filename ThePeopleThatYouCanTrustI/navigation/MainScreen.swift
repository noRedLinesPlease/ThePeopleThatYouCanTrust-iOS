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
    
    @State var shouldDismissModal: Bool = true
    @State var selection: SideBarRowType = .searchCompanies
    @State var selectedSideMenuTab = 0
    @State var isSideBarOpened = false
    @Binding var appUpdateAvailable: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                switch selection {
                case .aboutUs:
                    AboutUsView()
                case .searchCompanies:
                    SearchCompaniesView()
                case .allCompanies:
                    AllCompaniesView()
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
        .alert("App update available! \n Update below to see the latest features.", isPresented: $appUpdateAvailable) {
            Button ("Update") {
                let url = URL(string: "https://apps.apple.com/us/app/thepeoplethatyoucantrust/id6479319870")!
                UIApplication.shared.open(url)
            }
            Button("Dismiss") {
                appUpdateAvailable = false
                selection = .searchCompanies
            }
        }
    }
}
