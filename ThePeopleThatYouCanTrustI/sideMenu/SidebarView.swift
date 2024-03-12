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
    
    
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.6
    var sideBarHeight = UIScreen.main.bounds.size.height * 0.1
    var menuColor: Color = Color(hex: "FF6200EE")
    
    var body: some View {
        ZStack {
            content
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var content: some View {
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
            .background(.white)
            
        }
        .fixedSize()
        //.frame(width: sideBarWidth, height: sideBarHeight)
        .offset(x: isSidebarVisible ? -40 : -sideBarWidth, y: isSidebarVisible ? -40 : -sideBarHeight)
        .animation(.default, value: isSidebarVisible)
        .padding(.leading, 14).padding(.top, 30)
        
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
                            .foregroundColor(isSelected ? menuColor : .black)
                            .frame(width: 18, height: 18)
                    }
                    .frame(width: 28, height: 20)
                    Text(title)
                        .font(.system(
                            size: 12,
                            weight: .bold
                        )
                        )
                        .foregroundStyle(
                            isSelected ? menuColor : .black
                        )
                    Spacer()
                }
            }
        }
        .frame(width: sideBarWidth)
        .padding(.bottom, 6)
        .padding(.top, 6)
        .background(
            isSelected ? .purple.opacity(0.3) : .white
//            LinearGradient(colors: [isSelected ? .purple.opacity(0.5) : .white, .white],
//                           startPoint: .leading, endPoint: .trailing)
        )
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))

    }
}


