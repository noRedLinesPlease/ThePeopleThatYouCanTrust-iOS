//
//  ThePeopleThatYouCanTrustIApp.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/9/24.
//

import SwiftUI

@available(iOS 17.0, *)
@main
struct ThePeopleThatYouCanTrustIApp: App {
    @StateObject var networkMonitor = NetworkMonitor()
    @StateObject var swiftUISpeech = SwiftUISpeech()

    var body: some Scene {
        WindowGroup {
            //Change back to CheckIfAppIsUpdatedScreen before releasing
            MainScreen()
                    .environmentObject(networkMonitor)
                    .environmentObject(swiftUISpeech)
        }
    }
}
