//
//  DefaultCompaniesView.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/10/24.
//

import Foundation
import SwiftUI

func DefaultCompanyListView(
    companyList: [CompanyInfo],
    openUrl: OpenURLAction
) -> some View {
    ForEach(
        companyList,
        id: \.self
    ) { company in
        VStack(alignment: .center, spacing: 6) {
            let logoImageSize = "?format=200w"
            let logoUrl = (company.companyLogoList.first?.logoUrl ?? "") + (logoImageSize)
            
            Divider()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .overlay(.blue)
            
            Text(company.companyName)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.system(size: 14))
            
            HStack {
                AsyncImage(url: URL(string: logoUrl)) { image in
                    image
                        .resizable()
                        .imageScale(.small)
                        .clipped()
                        .padding(3)
                        .frame(maxWidth: 160, alignment: .center)
                    
                } placeholder: {
                    ProgressView()
                }
            }.frame(maxWidth: .infinity, maxHeight: 100)
            
        }
        .listRowSeparatorTint(.blue)
        .onTapGesture {
            let companyWeb = company.companyLogoList.first?.companyLink
            openUrl(URL(string: companyWeb  ?? "")!)
        }
    }
    .listRowBackground(Color.darkModeOrNot)
    .listRowSeparator(.hidden)
}


