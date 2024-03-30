//
//  SidebarView.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/10/24.
//

import Foundation
import SwiftUI

struct SideBarView : View {
    @Binding var selectedSideMenuTab: SideBarRowType
    @Binding var isSidebarVisible: Bool
    @ObservedObject var navigationManager : NavigationManager
    
   var sideBarWidth = UIScreen.main.bounds.size.width * 0.5
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(SideBarRowType.allCases, id: \.self) {
                    row in
                    RowView(
                        isSelected: selectedSideMenuTab.rawValue == row.rawValue,
                        imageName: row.iconName,
                        title: row.title
                    ) {
                        navigationManager.pageSelection.value = row.self
                        selectedSideMenuTab = row
                        isSidebarVisible.toggle()
                    }        

                }
            }
            .padding(.top, 5)
            .padding(.horizontal, 40)
            .padding(.bottom, 10)
            .background(Color.sidemenuDarkOrNot)
            
        }
        .padding(.leading, 14)
        
    }
    
    func RowView(
        isSelected: Bool,
        imageName: String,
        title: String,
        hideDivider: Bool = true,
        action: @escaping (()->())
    ) -> some View {
        Button{
            action()
        } label: {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 10){
                    ZStack{
                        Image(systemName: imageName)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(isSelected ? Color.darkModeSideText : Color.sideMenuTextDark)
                            .frame(width: 18, height: 18)
                    }
                    .frame(width: 28, height: 20)
                    Text(title)
                        .font(.system(size: 12,weight: .bold))
                        .foregroundStyle(
                            isSelected ? Color.darkModeSideText : Color.sideMenuTextDark)
                    Spacer()
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .frame(width: sideBarWidth)
        .padding(.bottom, 6)
        .padding(.top, 6)
        .background(
            isSelected ? Color.sidemenuSelectedDark : Color.sidemenuDarkOrNot
        )
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 6, height: 5)))
        
    }
}


