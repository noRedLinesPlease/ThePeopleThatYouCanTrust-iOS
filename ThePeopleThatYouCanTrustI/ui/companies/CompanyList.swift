//
//  CompanyList.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/10/24.
//

import SwiftUI

class CompanyList: Codable {
    var companies: [CompanyInfo] = []
    let id = UUID()
    
    private enum CodingKeys: String, CodingKey {
        case companies = "products"
    }
    
    init(companies: [CompanyInfo]) {
        self.companies = companies
    }
}

class CompanyInfo : Codable, Hashable {
    var categoryTag = ""
    static func == (lhs: CompanyInfo, rhs: CompanyInfo) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(companyName)
        hasher.combine(categoryTag)
        }
    
    let id = UUID()
    
    let companyName: String
    let companyCategories: [String]
    let companyLogoList: [CompanyLogoImage]
    
    private enum CodingKeys: String, CodingKey {
        case companyName = "name"
        case companyCatergories = "tags"
        case companyLogoList = "images"
    }
    
    init(companyName: String, companyCatergories: [String], companyLogoList: [CompanyLogoImage]) {
          self.companyName = companyName
          self.companyCategories = companyCatergories
          self.companyLogoList = companyLogoList
      }
    
    required init(from decoder:Decoder) throws {
         let values = try decoder.container(keyedBy: CodingKeys.self)
         companyName = try values.decode(String.self, forKey: .companyName)
         companyCategories = try values.decode([String].self, forKey: .companyCatergories)
         companyLogoList = try values.decode([CompanyLogoImage].self, forKey: .companyLogoList)
     }
    
    public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(self.companyName, forKey: .companyName)
            try container.encode(self.companyCategories, forKey: .companyCatergories)
            try container.encode(self.companyLogoList, forKey: .companyLogoList)
        }
}
    
    struct CompanyLogoImage: Codable, Hashable {
        func hash(into hasher: inout Hasher) {
                hasher.combine(logoUrl)
                hasher.combine(companyLink)
            }
        
        let id = UUID()
        
        let logoUrl: String
        let companyLink: String
        let imageSizes: [String]

        private enum CodingKeys: String, CodingKey {
            case logoUrl = "url"
            case companyLink = "altText"
            case imageSizes = "availableFormats"
        }
    }



