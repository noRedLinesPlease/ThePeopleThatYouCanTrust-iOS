//
//  ThePeopleThatYouCanTrustIApp.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/9/24.
//

import SwiftUI
import OneSignalFramework


@main
struct ThePeopleThatYouCanTrustIApp: App {
    @StateObject var networkMonitor = NetworkMonitor()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    
    var body: some Scene {
        WindowGroup {
            CheckIfAppIsUpatedScreen()
                    .environmentObject(networkMonitor)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    // Called once when the app finishes launching
    // This is the earliest point to initialize SDKs
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        // Enable verbose logging to debug issues (remove in production)
        OneSignal.Debug.setLogLevel(.LL_VERBOSE)
        
        // Replace with your 36-character App ID from Dashboard > Settings > Keys & IDs
        OneSignal.initialize("5f975718-7f3d-43e6-9101-e230069a4526", withLaunchOptions: launchOptions)
        
        // Prompt user for push notification permission
        // In production, consider using an in-app message instead for better opt-in rates
        // fallbackToSettings: if previously denied, opens iOS Settings to re-enable
        OneSignal.Notifications.requestPermission({ accepted in
            print("User accepted notifications: \(accepted)")
        }, fallbackToSettings: false)
        
        return true
    }
}


