//
//  ApiFetchHandler.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/10/24.
//

import Foundation
import Alamofire
import SwiftUI

class APIFetchHandler: ObservableObject {
    static let sharedInstance = APIFetchHandler()
    @Published var companies: [CompanyInfo] = [];
    
    func fetchAPIData(completion: @escaping ([CompanyInfo], Bool) -> Void) {
        let headers: HTTPHeaders = ["Authorization": "Bearer " + "dca6ca82-937d-4796-9ed2-0e1d16c4be60"]
        let url = URL(string: "https://api.squarespace.com/1.1/commerce/products?type=PHYSICAL")!
        let task = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers) .responseData {
            responseData in
            do {
                let companiesFromAPI = try JSONDecoder().decode(CompanyList.self, from: responseData.data!)
                
                self.companies = companiesFromAPI.companies
            } catch {
                print("Error with parsing")
            }
            completion(self.companies, false)
        }
        
        task.resume()
    }
}

