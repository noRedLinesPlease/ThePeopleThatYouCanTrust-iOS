//
//  AppUpdateCheckerView.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 4/23/24.
//

import SwiftUI

enum AppUpdateErrors : Error {
    case MainDictError
    case VersionError
    case DataIsNullError
}

struct CheckIfAppIsUpatedScreen : View {
    @Injection(\.navigationManager) var navigationManager
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    
    @State var appNeedsToBeUpdated: Bool = false
    @State var isLoading: Bool = true
    @State var isAppUpdateAvailable = false
    @State var selection: SideBarRowType = .searchCompanies
    @State var shouldDismissModal = false
    @State var versionInstalled2 = ""
    
    var body: some View {
        VStack{
            if(!networkMonitor.isConnected){
                NoNetworkView()
            } else {
                if(isLoading) {
                    Image(
                        "updatedLogo"
                    ).resizable()
                        .frame(width: 160, height: 160)
                    
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                }
                else {
                    MainScreen(appUpdateAvailable: $appNeedsToBeUpdated)
                }
            }
        }
        .onAppear {
            setVersionInstalledOnPhone()
            GetLatestVersion.latestVersionNetworkCall.getLatestVersionFromWebsite() { latestVersion, isFetchingVersionNumber, error in
                if(error != nil || versionInstalled2.isEmpty) {
                    appNeedsToBeUpdated = false
                    isLoading = isFetchingVersionNumber
                    print(error as Any)
                } else {
                    if(versionInstalled2 != latestVersion) {
                        appNeedsToBeUpdated = true
                        isLoading = isFetchingVersionNumber
                    } else {
                        appNeedsToBeUpdated = false
                        isLoading = isFetchingVersionNumber
                    }
                }
                print(versionInstalled2)
                print(latestVersion)
                print("App needs to be updated: \($appNeedsToBeUpdated)")
            }
            
        }
    }
    
    func setVersionInstalledOnPhone() {
        guard let info = Bundle.main.infoDictionary,
              let currentVersion = info["CFBundleShortVersionString"] as? String
        else {
            return
        }
        versionInstalled2 = currentVersion
    }
}
