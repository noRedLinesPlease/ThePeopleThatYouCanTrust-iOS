//
//  ThePeopleThatYouCanTrustIApp.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/9/24.
//

import SwiftUI

@main
struct ThePeopleThatYouCanTrustIApp: App {
    @Environment(\.colorScheme) var phoneDarkMode
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
                MainScreen()
                    .environmentObject(networkMonitor)
        }
    }
}
