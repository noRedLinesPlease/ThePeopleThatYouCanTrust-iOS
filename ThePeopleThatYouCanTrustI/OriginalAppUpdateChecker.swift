//
//  AppStoreUpdate.swift
//
//  Created by CodeChanger on 03/11/19.
//  Copyright © 2019 CodeChanger. All rights reserved.
//


import SwiftUI


//class AppUpdatedClass : ObservableObject {
//    var appNeedsToBeUpdated: Bool = false
//    var isCheckingForUpdate = true
//    static let appUpdateCheckSharedInstance = AppUpdatedClass()
    
    //    func isUpdateAvailable(completion: @escaping (Bool, Error?) -> Void) throws -> URLSessionDataTask {
    //        guard let info = Bundle.main.infoDictionary,
    //              let currentVersion = info["CFBundleShortVersionString"] as? String,
    //              let identifier = info["CFBundleIdentifier"] as? String,
    //              let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
    //            throw AppUpdateErrors.MainDictError
    //        }
    //        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    //            do {
    //                if let error = error { throw error }
    //                guard let data = data else { throw AppUpdateErrors.DataIsNullError }
    //                let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
    //                guard let result = (json?["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String else {
    //                    throw AppUpdateErrors.VersionError
    //                }
    //                print(version)
    //                print(currentVersion)
    //                completion(version != currentVersion, nil)
    //            } catch {
    //                completion(nil, error)
    //            }
    //        }
    //        task.resume()
    //        return task
    //    }
    
    
//         func isUpdateAvailableNew(completion: @escaping (Bool, Error?, Bool) -> Void) async {
//        guard let info = Bundle.main.infoDictionary,
//              let currentVersion = info["CFBundleShortVersionString"] as? String,
//              let identifier = info["CFBundleIdentifier"] as? String,
//              let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
//            completion(false, AppUpdateErrors.MainDictError,false)
//            return
//        }
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            do {
//                if let error = error { throw error }
//                guard let data = data else { throw AppUpdateErrors.DataIsNullError }
//                let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
//                guard let result = (json?["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String else {
//                    throw AppUpdateErrors.VersionError
//                }
//                print(version)
//                print(currentVersion)
//                completion(version != currentVersion, nil, false)
//            } catch {
//                completion(false, error, false)
//            }
//        }
//        task.resume()
//    }
// }

