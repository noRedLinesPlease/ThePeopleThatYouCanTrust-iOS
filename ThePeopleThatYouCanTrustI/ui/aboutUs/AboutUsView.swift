//
//  HomeView.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/10/24.
//

import SwiftUI
import Combine

class AboutUsViewModel: ObservableObject {
    @Injection(\.navigationManager) var navigationManager
}

struct AboutUsView: View {
    @StateObject var viewModel = AboutUsViewModel()
    @State private var headerText: String = ""
    @State private var headerBodyText: String = ""
    @State private var subHeaderText: String = ""
    @State private var subHeaderBodyText: String = ""
    @State var isContentLoading: Bool = true
    var test = UIScreen.main.bounds.size.height
    
    var body: some View {
        ScrollView {
            VStack(spacing: 4) {
                Image(
                    "updatedLogo"
                )
                .resizable()
                .frame(width: 160, height: 160)
                
                Divider()
                    .frame(width: .none, height: 1)
                    .overlay(.blue)
                
                if(isContentLoading) {
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                }
                Text(headerText)
                    .font(Font.custom("BungeeSpice-Regular", size: 24))
                    .padding(.top, 4)
                    .padding(.bottom, 8)
                    .multilineTextAlignment(.center)
                
                ZStack {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 130)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .foregroundStyle(Color(hex: "#ff591c"))
                    
                    Image("aboutUsImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 120, maxHeight: 120)
                }
                
                Text(headerBodyText)
                    .font(Font.custom("Truculenta-SemiBold", size: 17))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 10)
                
                Text(subHeaderText)
                    .font(Font.custom("ProtestGuerrilla-Regular", size: 26))
                    .foregroundStyle(Color(hex: "#45C0C6"))
                
                Text(subHeaderBodyText)
                    .font(Font.custom("Kurale-Regular", size: 15))
                    .multilineTextAlignment(.center)
                
                Button(action: { viewModel.navigationManager.pageSelection.send(.browseCompanies) }) {
                    Text("browse companies")
                        .font(Font.custom("PermanentMarker-Regular", size: 16))
                        .foregroundStyle(.white)
                        .padding(5)
                }
                .background(Color(hex: "#45C0C6"))
                .buttonStyle(.bordered)
                .padding(.top, 13)
                .padding()
            }
            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            .onAppear {
                AboutUsNetworkCall.aboutUsNetworkCall.getAboutUsContent() {
                    header, body, subHeader, subHeaderBody, isLoading in
                    headerText =  header
                    headerBodyText = body
                    subHeaderText = subHeader
                    subHeaderBodyText = subHeaderBody
                    isContentLoading = isLoading
                }
            }
            .padding(.horizontal, 6)
        }
        .background(Color.darkModeOrNot)
    }
}

