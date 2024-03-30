//
//  SearchingCompaniesView.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/10/24.
//

import SwiftUI

func SearchingCompaniesListView(
    filteredList1 : [CompanyInfo],
    openUrl: OpenURLAction
) -> some View {
    ForEach(
        filteredList1,
        id: \.self
    ) { company in
        VStack(alignment: .center, spacing: 0) {
            let logoImageSize = "?format=300w"
            let logoUrl = (company.companyLogoList.first?.logoUrl ?? "") + (logoImageSize)
            
            HStack(alignment: .center, spacing: 15) {
                SearchImageView(withURL: logoUrl)
                
                Text(company.companyName).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 16))
            }
        }.onTapGesture {
            let companyWeb = company.companyLogoList.first?.companyLink
            openUrl(URL(string: companyWeb  ?? "")!)
        }
    }
    .listRowBackground(Color.darkModeOrNot)
    .listRowSeparator(/*@START_MENU_TOKEN@*/.visible/*@END_MENU_TOKEN@*/)
    .listRowSeparatorTint(.blue)
    .listSectionSeparator(.hidden, edges: .top)
}

