//
//  AllCompaniesView.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 5/4/24.
//

import SwiftUI

public extension Sequence where Element : Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return self.filter { seen.insert($0).inserted }
    }
}

struct AllCompaniesView: View {
    @Environment(\.openURL) private var openURL
    
    @State private var companyList: [CompanyInfo] = []
    @State private var productList: [ProductAkaCompany] = []
    @State private var newBusinessTypeList: [String] = []
    @State private var businessTypeListFromApi: [String] = []
    @State private var categorySelected = ""
    @State private var noCategorySelected = true
    @State var catergorySelectionSelected: Bool = false
    @State var isLoading: Bool = true
    @State private var companyRank = 0
    @State private var screenSizeWidth = UIScreen.main.bounds.width - 10
    let items = [GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]
    
    
    var filteredList: [CompanyInfo] {
        companyList.filter {
            if(noCategorySelected) {
                true
            } else {
                $0.businessTypeString.contains(categorySelected)
            }
        }
    }
    
    var body: some View {
        VStack() {
            Image(
                ImageResource.updatedLogo
            )
            .resizable()
            .frame(width: 150, height: 150)
            
            LazyVGrid(columns: Array(repeating: .init(), count: 3),spacing: 0) {
                ForEach(
                    businessTypeListFromApi,
                    id: \.self
                ) { category in
                    Text(category)
                        .font(.system(size: 14))
                        .foregroundStyle((category == categorySelected) ? Color(hex: "#45C0C6") : Color.blue)
                        .underline()
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(3)
                        .onTapGesture {
                            categorySelected = category
                            noCategorySelected = false
                        }
                }
                
            }
            .frame(maxWidth: screenSizeWidth)
            
            if(isLoading) {
                ProgressView().progressViewStyle(CircularProgressViewStyle())
            }
            else {
                filterCompanies().background(Color.darkModeOrNot)
            }
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.darkModeOrNot)
            .onAppear {
                APIFetchHandler.sharedInstance.fetchAPIData { companies, isListLoaded in
                    companyList = companies
                    isLoading = isListLoaded
                    companyList.forEach { company in
                        productList = company.products
                        let businessCompanyCategory = company.companyListingCategory.joined(separator: ",")
                        company.businessTypeString = businessCompanyCategory
                        company.companyListingCategory.forEach { listing in
                            businessTypeListFromApi.append(listing)
                        }
                    }
                    businessTypeListFromApi = businessTypeListFromApi.sorted(by: {$0.prefix(2) < $1.prefix(2) }).uniqued()
                }
            }
    }
    
    
    func filterCompanies() -> some View {
        List {
            DefaultCompanyListView(companyList: filteredList, openUrl: openURL)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .listRowSeparator(/*@START_MENU_TOKEN@*/.visible/*@END_MENU_TOKEN@*/)
        .listRowBackground(Color.darkModeOrNot)        
    }
}


