//
//  UpdateAppNetworkCall.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 5/21/24.
//

import Foundation
import SwiftUI
import SwiftSoup

class GetLatestVersion : ObservableObject {
    static let latestVersionNetworkCall = GetLatestVersion()
    
    @Published var latestVersionOfApp: String = ""
    @Published var thereWasAnError: Bool?
    
    let url = URL(string: "https://alligator-beige-t5e3.squarespace.com/")
    
    func getLatestVersionFromWebsite(completion: @escaping (String, Bool, Bool?) -> Void) {
        Task{
            let theString =  await fetchFromURL(url!) //Put your URL here!
            //We use a do/catch block here because SwiftSoup.parse can throw
            do{
                let document = try SwiftSoup.parse(theString) //This is now the parsed document if it worked
                
                let versionFromWebsite = try document.getElementsByClass("fe-block-yui_3_17_2_1_1715521103669_7199")
                
                self.latestVersionOfApp = try versionFromWebsite.text()
                if(latestVersionOfApp.isEmpty) {
                    self.thereWasAnError = true
                }
                
            } catch { //SwiftSoup failed to parse the String into a document, so we need to handle the error
                print("Failed to parse")
                self.thereWasAnError = true
            }
            completion(
                self.latestVersionOfApp,
                false,
                self.thereWasAnError
            )
        }
    }
    
    func fetchFromURL(_ url: URL) async -> String {
        let session = URLSession.shared
        var websiteContent = ""
        do {
            let (theStringAsData, _) = try await session.data(from: (url))
            websiteContent = String(data: theStringAsData, encoding: .utf8) ?? "NOPE from fetch url"
        }
        catch {
            self.thereWasAnError = true
            print("URL failed")
        }
        return websiteContent
    }
}
