//
//  SidebarRowType.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/10/24.
//

enum SideBarRowType: Int, CaseIterable {
    case home = 0
    case companies = 1
    case shareApp = 2
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .companies:
            return "Companies"
        case .shareApp:
            return "Share App"
        }
    }
        
        var iconName: String{
            switch self {
            case .home:
                return "house.fill"
            case .companies:
                return "building.fill"
            case .shareApp:
                return "square.and.arrow.up"
            }
        }
    }
