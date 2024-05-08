//
//  CompanyListView.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/10/24.
//

import SwiftUI

struct SearchCompaniesView: View {
    @Environment(\.openURL) private var openURL
    
    @State private var companyList: [CompanyInfo] = []
    @State private var productList: [ProductAkaCompany] = []
    @State private var categoriesString = ""
    @State private var companyRank = 0
    @FocusState private var isFocused: Bool
    @State var searchBarText: String = ""
    @State var isLoading: Bool = true
    @State var catergorySelectionSelected: Bool = false
    
    var filteredList: [CompanyInfo] {
        companyList.filter {
            if(searchBarText.isEmpty && searchBarText.count < 3) {
                false
            } else {
                ($0.categoryTag
                    .lowercased()
                    .contains(searchBarText.lowercased()
                        .trimmingCharacters(in: .whitespacesAndNewlines))
                 || $0.companyName.lowercased()
                    .contains(searchBarText.lowercased()
                        .trimmingCharacters(in: .whitespacesAndNewlines)))
            }
        }
    }
    
    var body: some View {
        VStack {
            Image(
                ImageResource.updatedLogo
            ).resizable()
                .frame(width: 140, height: 140)
            
            Text("What can we help you find today?")
                .font(Font.custom("ProtestGuerrilla-Regular", size: 30))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.bottom, 10)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color(hex: "#45C0C6"))
                .background(Color.darkModeOrNot)
            
            CustomSearchBar(searchText: $searchBarText, isFocused: $isFocused)
            
            filterCompanies().background(Color.darkModeOrNot)
        }
        .background(Color.darkModeOrNot)
        .onAppear {
            APIFetchHandler.sharedInstance.fetchAPIData { companies, isListLoaded in
                companyList = companies
                companyList.forEach { company in
                    company.categoryTag = company.companyCategoryTags.joined(separator: ",")
                    productList = company.products
                }
            }
        }
    }
    
    func filterCompanies() -> some View {
        List {
            if(!searchBarText.isEmpty && searchBarText.count > 2) {
                if(filteredList.isEmpty) {
                    Text("No results found").listRowBackground(Color.darkModeOrNot)
                } else if(isFocused) {
                    SearchingListLayoutView(filteredList1: filteredList, openUrl: openURL)
                } else {
                    DefaultCompanyListView(companyList: filteredList, openUrl: openURL)
                }
            }
        }
        .padding(.horizontal, -10)
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .listRowSeparator(/*@START_MENU_TOKEN@*/.visible/*@END_MENU_TOKEN@*/)
        .listRowBackground(Color.darkModeOrNot)
    }
}
