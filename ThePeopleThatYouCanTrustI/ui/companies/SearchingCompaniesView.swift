//
//  SearchingCompaniesView.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/10/24.
//

import SwiftUI

func SearchingCompaniesListView(filteredList1 : [CompanyInfo], openUrl: OpenURLAction) -> some View {
    ForEach(
        filteredList1,
        id: \.self
    ) { company in
        VStack(alignment: .center, spacing: 0) {
            //let testing = "?format=100w"
            let logoUrl = company.companyLogoList.first?.logoUrl ?? ""
            HStack(alignment: .center, spacing: 15) {
                AsyncImage(url: URL(string: logoUrl)) { image in
                    image
                        .resizable()
                        .clipped()
                        .padding(3)
                        .frame(maxWidth: 60, maxHeight: 60, alignment: .center)
                } placeholder: {
                    ProgressView()
                }.onAppear()
                
                Text(company.companyName).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 16))
            }
        }.onTapGesture {
            let companyWeb = company.companyLogoList.first?.companyLink
            openUrl(URL(string: companyWeb  ?? "")!)
        }
    }
    .listRowBackground(Color(hex: "#f6ede0"))
    .listRowSeparator(/*@START_MENU_TOKEN@*/.visible/*@END_MENU_TOKEN@*/)
}

