//
//  SidebarRowType.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/10/24.
//

enum SideBarRowType: Int, CaseIterable {
    case home = 0
    case secondTab = 1
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .secondTab:
            return "Companies"
        }
    }
        
        var iconName: String{
            switch self {
            case .home:
                return "house.fill"
            case .secondTab:
                return "building.fill"
            }
        }
    }
