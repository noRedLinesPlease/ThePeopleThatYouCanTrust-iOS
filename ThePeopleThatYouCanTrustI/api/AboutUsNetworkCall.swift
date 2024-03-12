//
//  AboutUsNetworkCall.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/10/24.
//

import Foundation
import SwiftUI
import SwiftSoup

class AboutUsNetworkCall: ObservableObject {
    static let aboutUsNetworkCall = AboutUsNetworkCall()
    
    
    @Published var header: String = "Nope"
    @Published var headerBody: String = "No Body"
    @Published var subHeader: String = "No Body"
    @Published var subHeaderBody: String = "No Body"
    //@Published var isLoaded: Bool = false
    let url = URL(string: "https://alligator-beige-t5e3.squarespace.com/")
    
    func getAboutUsContent(completion: @escaping (String, String, String, String, Bool) -> Void) {
        Task{
            let theString =  await fetchFromURL(url!) //Put your URL here!
            //We use a do/catch block here because SwiftSoup.parse can throw
                do{
                    let document = try SwiftSoup.parse(theString) //This is now the parsed document if it worked
                    
                    let headerFromWebsite = try document.getElementsByClass("fe-block-52548690efe141736640")
                    let headerBodyFromWebsite = try document.getElementsByClass("fe-block-a081cdeabc4137be9f5b")
                    let subHeaderFromWebsite = try document.getElementsByClass("fe-block-afea2256dc047051d8ee")
                    let subHeaderBodyFromWebsite = try document.getElementsByClass("fe-block-57dc43433ef1172548d6")
                    
                    self.header = try headerFromWebsite.text()
                    self.headerBody = try headerBodyFromWebsite.text()
                    self.subHeader = try subHeaderFromWebsite.text()
                    self.subHeaderBody = try subHeaderBodyFromWebsite.text()
                    
                    
                    
                } catch { //SwiftSoup failed to parse the String into a document, so we need to handle the error
                    print("Failed to parse")
                }
            completion(
                self.header,
                self.headerBody,
                self.subHeader,
                self.subHeaderBody,
                false
            )
        }
    }
    
    func fetchFromURL(_ url: URL) async -> String {
        let session = URLSession.shared
        var test = ""
        do {
            let (theStringAsData, _) = try await session.data(from: (url))
            test = String(data: theStringAsData, encoding: .utf8) ?? "NOPE from fetch url"
        }
        catch {
            print("URL failed")
        }
        return test
    }
}



