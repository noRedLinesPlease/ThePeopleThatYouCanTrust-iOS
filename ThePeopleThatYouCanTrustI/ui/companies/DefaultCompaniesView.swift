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
                let logoImageSize = "?format=300w"
                let logoUrl = (company.companyLogoList.first?.logoUrl ?? "") + (logoImageSize)
                
                Divider()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .overlay(.blue)
                
                Text(company.companyName)
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                
                ImageView(withURL: logoUrl)
                    .frame(maxWidth: 220, maxHeight: 180)
            }
            .frame(maxWidth: .infinity,maxHeight: 140)
            .listRowSeparatorTint(.blue)
            .onTapGesture {
                let companyWeb = company.companyLogoList.first?.companyLink
                openUrl(URL(string: companyWeb  ?? "")!)
            }
    }
    .listRowBackground(Color.darkModeOrNot)
    .listRowSeparator(.hidden)
}
