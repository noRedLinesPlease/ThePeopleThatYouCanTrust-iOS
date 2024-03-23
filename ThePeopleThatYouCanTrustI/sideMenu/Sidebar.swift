//
//  Sidebar.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/10/24.
//

import SwiftUI

struct SideMenu: View {
    @Binding var isSidebarVisible: Bool
    var contentVar: AnyView
    var edgeTransition: AnyTransition = .move(edge: .leading)
    var menuColor: Color = Color(.init(red: 52 / 255, green: 70 / 255, blue: 182 / 255, alpha: 1))
    
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if(isSidebarVisible) {
                GeometryReader { _ in
                    EmptyView()
                }
                .background(.black.opacity(0.6))
                .opacity(isSidebarVisible ? 1 : 0)
                .animation(.default, value: isSidebarVisible)
                .onTapGesture {
                    isSidebarVisible.toggle()
                }
                
                contentVar
                    .transition(edgeTransition)
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        //.edgesIgnoringSafeArea(.all)
    }
}


