//
//  CustomColor.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/10/24.
//

import SwiftUI
import Network

class NetworkMonitor: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    var isConnected = false

    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
            Task {
                await MainActor.run {
                    self.objectWillChange.send()
                }
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}
