//
//  ThePeopleThatYouCanTrustIApp.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/9/24.
//

import SwiftUI

@main
struct ThePeopleThatYouCanTrustIApp: App {
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            CheckIfAppIsUpatedScreen()
                    .environmentObject(networkMonitor)
        }
    }
}
