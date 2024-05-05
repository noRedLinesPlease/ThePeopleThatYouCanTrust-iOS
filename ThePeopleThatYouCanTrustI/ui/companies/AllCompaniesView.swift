//
//  AllCompaniesView.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 5/4/24.
//

import SwiftUI

struct AllCompaniesView: View {
    @Environment(\.openURL) private var openURL
    
    @State private var companyList: [CompanyInfo] = []
    @State private var productList: [ProductAkaCompany] = []
    @State private var companyCategoryList: [String] = ["Health & Wellness", "Home Improvement", "Yoga", "Self Care", "Financial Services", "All Companies"]
    @State private var categorySelected = ""
    @State private var noCategorySelected = true
    @State var catergorySelectionSelected: Bool = false
    @State var isLoading: Bool = true
    @State private var companyRank = 0
    
    var filteredList: [CompanyInfo] {
        companyList.filter {
            if(noCategorySelected) {
                true
            } else {
                $0.companyListingCategory.first == categorySelected
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Image(
                ImageResource.updatedLogo
            ).resizable()
                .frame(width: 150, height: 150)
            HStack {
                ForEach(
                    companyCategoryList,
                    id: \.self
                ) { category in
                    Text(category)
                        .font(.callout)
                        .foregroundStyle((category == categorySelected) ? Color(hex: "#45C0C6") : Color.blue)
                        .underline()
                        .padding(.trailing, 6)
                        .onTapGesture {
                            categorySelected = category
                            noCategorySelected = false
                            print(categorySelected)
                            
                        }
                }
            }
            
            if(isLoading) {
                ProgressView().progressViewStyle(CircularProgressViewStyle())
            }
            else {
                filterCompanies().background(Color.darkModeOrNot)
            }
        }
        .background(Color.darkModeOrNot)
        .onAppear {
            APIFetchHandler.sharedInstance.fetchAPIData { companies, isListLoaded in
                companyList = companies
                isLoading = isListLoaded
                companyList.forEach { company in
                    print("CompanyListingOnAppear: \(company.companyListingCategory.first)")
                    productList = company.products
                }
            }
        }
    }
    
    func filterCompanies() -> some View {
        List {
            DefaultCompanyListView(companyList: filteredList, openUrl: openURL)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .listRowSeparator(/*@START_MENU_TOKEN@*/.visible/*@END_MENU_TOKEN@*/)
        .listRowBackground(Color.darkModeOrNot)
    }
}
