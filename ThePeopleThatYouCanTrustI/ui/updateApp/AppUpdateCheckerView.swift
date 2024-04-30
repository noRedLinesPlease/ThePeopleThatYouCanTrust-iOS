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

@available(iOS 17.0, *)
struct CheckIfAppIsUpatedScreen : View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @State var appNeedsToBeUpdated: Bool = false
    @State var isLoading: Bool = true
    
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
                    if(appNeedsToBeUpdated) {
                        AppUpateAlertView()
                    } else {
                        MainScreen()
                    }
                }
            }
        }
        .onAppear {
            Task {
                await isUpdateAvailable { appIsUpdated, error, isChecking in
                    if(error != nil) {
                        appNeedsToBeUpdated = false
                        isLoading = isChecking
                    } else {
                        appNeedsToBeUpdated = appIsUpdated
                        isLoading = isChecking
                    }
                }
            }
        }
    }
    
    
    func isUpdateAvailableTest() -> Bool {
        guard let info = Bundle.main.infoDictionary,
              let currentVersionInstalled = info["CFBundleShortVersionString"] as? String
        else {
            print ("error with getting version")
            return false
        }
        let versionAvailable = "1.3"
        print(versionAvailable)
        print(currentVersionInstalled)
        
        if(currentVersionInstalled != versionAvailable) {
            return true
        }
        return false
    }
    
    func isUpdateAvailable(completion: @escaping (Bool, Error?, Bool) -> Void) async {
        guard let info = Bundle.main.infoDictionary,
              let currentVersion = info["CFBundleShortVersionString"] as? String,
              let identifier = info["CFBundleIdentifier"] as? String,
              let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
            completion(false, AppUpdateErrors.MainDictError, false)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let error = error { throw error }
                guard let data = data else { throw AppUpdateErrors.DataIsNullError }
                let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
                guard let result = (json?["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String else {
                    throw AppUpdateErrors.VersionError
                }
                print(version)
                print(currentVersion)
                completion(version != currentVersion, nil, false)
            } catch {
                completion(false, error, false)
            }
        }
        task.resume()
    }
}
