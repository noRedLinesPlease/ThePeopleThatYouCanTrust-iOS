//
//  HomeScreen.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 4/29/24.
//

import SwiftUI
import Speech
import Foundation

@available(iOS 17.0, *)
struct HomeScreen : View {
    @Environment(\.openURL) private var openURL
    @EnvironmentObject var swiftUISpeech: SwiftUISpeech

    
    @State private var companyList: [CompanyInfo] = []
    @State private var companyCatergoryList: [String] = []
    @State private var categoriesString = ""
    @State private var companyRank = 0
    @FocusState private var isFocused: Bool
    @State var searchBarText: String = ""
    @State var isLoading: Bool = true
    @State var catergorySelectionSelected: Bool = false
    @State var testing: Bool = true

    
    @State private var isRecording = false
    @State private var recognizedText = ""
    
    
    var filteredList: [CompanyInfo] {
        companyList.filter {
            if(searchBarText.isEmpty) {
                true
            } else {
                $0.categoryTag
                    .lowercased()
                    .contains(searchBarText.lowercased()
                        .trimmingCharacters(in: .whitespacesAndNewlines))
                || $0.companyName.lowercased()
                    .contains(searchBarText.lowercased()
                        .trimmingCharacters(in: .whitespacesAndNewlines))
            }
        }
    }
    
    var body: some View {
        VStack {
            Image(
                ImageResource.updatedLogo
            ).resizable()
                .frame(width: 160, height: 160)
            Text("What can we help you find today?")
                .font(.system(size: 18))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.bottom, 6)
                .background(Color.darkModeOrNot)
            
            swiftUISpeech.getButton()
            
            CustomSearchBar(searchText: $swiftUISpeech.outputText, isFocused: $isFocused)
            
            if(isLoading) {
                ProgressView().progressViewStyle(CircularProgressViewStyle())
            } else {
                filterCompanies().background(Color.darkModeOrNot)
            }
        }
            
            .background(Color.darkModeOrNot)
            .onAppear {
                Task {
                    await swiftUISpeech.requestMicrophone()

                }
                APIFetchHandler.sharedInstance.fetchAPIData { companies, isListLoaded in
                    companyList = companies
                    isLoading = isListLoaded
                    companyList.forEach { company in
                        company.categoryTag = company.companyCategories.joined(separator: ",")
                        
                    }
                }
            }
        }
        
        func filterCompanies() -> some View {
            List {
                if(filteredList.isEmpty) {
                    Text("No results found").listRowBackground(Color.darkModeOrNot)
                } else {
                    if(isFocused && !searchBarText.isEmpty) {
                        SearchingCompaniesListView(filteredList1: filteredList, openUrl: openURL)
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

