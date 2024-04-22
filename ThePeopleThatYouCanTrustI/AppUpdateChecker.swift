//
//  AppStoreUpdate.swift
//
//  Created by CodeChanger on 03/11/19.
//  Copyright © 2019 CodeChanger. All rights reserved.
//


import SwiftUI
enum AppUpdateErrors : Error {
    case MainDictError
    case VersionError
    case DataIsNullError
}

class AppUpdatedClass : ObservableObject {
    static let updatedSharedInstance = AppUpdatedClass()
        func isUpdateAvailable(completion: @escaping (Bool?, Error?) -> Void) throws -> URLSessionDataTask {
            guard let info = Bundle.main.infoDictionary,
                  let currentVersion = info["CFBundleShortVersionString"] as? String,
                  let identifier = info["CFBundleIdentifier"] as? String,
                  let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
                throw AppUpdateErrors.MainDictError
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
                    completion(version != currentVersion, nil)
                } catch {
                    completion(nil, error)
                }
            }
            task.resume()
            return task
        }
    }


