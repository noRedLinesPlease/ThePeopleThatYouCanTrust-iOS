//
//  CompaniesView.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/10/24.
//

import SwiftUI

struct CompaniesView: View {
    @Environment(\.openURL) private var openURL
    
    @State private var companyList: [CompanyInfo] = []
    @State private var companyCatergoryList: [String] = []
    @State private var categoriesString = ""
    @FocusState private var isFocused: Bool
    @State var searchBarText: String = ""
    @State var isLoading: Bool = true
    
    var filteredList: [CompanyInfo] {
        companyList.filter {
            if(searchBarText.isEmpty) {
                true
            } else {
                $0.categoryTag
                    .lowercased()
                    .contains(searchBarText.lowercased()
                    .trimmingCharacters(in: .whitespacesAndNewlines))
            }
        }
    }
    
    var body: some View {
        VStack {
            Image(
                "updatedLogo"
            ).resizable()
                .frame(width: 160, height: 160)
            
            CustomSearchBar(searchText: $searchBarText, isFocused: $isFocused)
            
            Divider()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .overlay(.blue)
            if(isLoading) {
                ProgressView().progressViewStyle(CircularProgressViewStyle())
            } else {
                filterCompaniesTest()
            }
        }
        .background(Color(hex: "#f6ede0"))
        .onAppear {
            APIFetchHandler.sharedInstance.fetchAPIData { companies, isListLoaded in
                companyList = companies
                isLoading = isListLoaded
                companyList.forEach { company in
                    company.categoryTag = company.companyCategories.joined(separator: ",")
                }
            }
        }
    }
    
    func filterCompaniesTest() -> some View {
        List {
            if(filteredList.isEmpty) {
                Text("No results found").listRowBackground(Color("#f6ede0"))
            } else {
                if(isFocused && !searchBarText.isEmpty) {
                    SearchingCompaniesListView(filteredList1:openUrl:)(filteredList, openURL)
                } else {
                    DefaultCompanyListView(companyList: filteredList, openUrl: openURL)
                }
            }
        }.listStyle(.plain)
            .scrollContentBackground(.hidden)
            .listRowSeparator(/*@START_MENU_TOKEN@*/.visible/*@END_MENU_TOKEN@*/)
            .listRowBackground(Color("#f6ede0"))
    }
}


