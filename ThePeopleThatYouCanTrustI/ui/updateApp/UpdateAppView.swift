//
//  PleaseUpdateAppView.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 4/20/24.
//

import SwiftUI


class AlertDismissViewModel: ObservableObject {
    @Injection(\.navigationManager) var navigationManager
}

struct AppUpateAlertView : View {
    @Injection(\.navigationManager) var navigationManager
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @StateObject var viewModel = AlertDismissViewModel()
    @Environment(\.dismiss) var dismiss
    
    
    @State var dismissModal = false
    @State var shouldDismiss: Bool = true
    @State var pageSelection: SideBarRowType = .searchCompanies
    var body: some View {
        VStack {
            Image("updatedLogo")
                .resizable()
                .frame(width: 250, height: 250)
        }
        .onReceive(navigationManager.pageSelection) { _ in
            pageSelection = .searchCompanies
        }
        //        .overlay {
        //            CustomAlert (
        //                title: "App update available",
        //                description: "Update the app to see what's new!",
        //                leftButtonAction: {
        //                    let url = URL(string: "https://apps.apple.com/us/app/thepeoplethatyoucantrust/id6479319870")!
        //                    UIApplication.shared.open(url)
        //                },
        //                leftButtonTitle: "Update",
        //                //rightButtonAction: { dismiss() },
        //                rightButtonTitle: "Dismiss",
        //                onDismissFunc: { dismiss() }
        //            )
        //        }
        .alert("App update available! \n Update below to see the latest features.", isPresented: $shouldDismiss) {
            Button ("Update") {
                let url = URL(string: "https://apps.apple.com/us/app/thepeoplethatyoucantrust/id6479319870")!
                UIApplication.shared.open(url)
            }
            Button("Dismiss") {
                shouldDismiss = true
                viewModel.navigationManager.pageSelection.send(.searchCompanies)
            }
//            CustomAlert (
//                title: "App update available",
//                description: "Update the app to see what's new!",
//                leftButtonAction: {
//                    let url = URL(string: "https://apps.apple.com/us/app/thepeoplethatyoucantrust/id6479319870")!
//                    UIApplication.shared.open(url)
//                },
//                leftButtonTitle: "Update",
//                //rightButtonAction: { dismiss() },
//                rightButtonTitle: "Dismiss",
//                onDismissFunc: { shouldDismiss = false }
//            )
        }
        .transition(.scale)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.darkModeOrNot)
    }
}

