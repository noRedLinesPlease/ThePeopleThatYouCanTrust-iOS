//
//  DefaultCompaniesView.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/10/24.
//

import Foundation
import SwiftUI

func DefaultCompanyListView(companyList: [CompanyInfo], openUrl: OpenURLAction) -> some View {
    ForEach(
        companyList,
        id: \.self
    ) { company in
        VStack(alignment: .center, spacing: 6) {
            let logoImageSize = "?format=500w"
            let logoUrl = (company.companyLogoList.first?.logoUrl ?? "") + (logoImageSize)
            
            Text(company.companyName).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 14))
            
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
                }.onAppear()
            }.frame(maxWidth: .infinity, maxHeight: 100)
            
        }.onTapGesture {
            let companyWeb = company.companyLogoList.first?.companyLink
            openUrl(URL(string: companyWeb  ?? "")!)
        }
    }.listRowBackground(Color(hex: "#f6ede0"))
        .listRowSeparator(/*@START_MENU_TOKEN@*/.visible/*@END_MENU_TOKEN@*/)
}


