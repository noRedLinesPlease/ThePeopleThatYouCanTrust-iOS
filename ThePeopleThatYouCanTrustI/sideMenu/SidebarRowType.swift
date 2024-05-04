//
//  SidebarRowType.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/10/24.
//

enum SideBarRowType: Int, CaseIterable {
    case aboutUs = 0
    case companies = 1
    case shareApp = 2
    
    var title: String{
        switch self {
        case .aboutUs:
            return "About Us"
        case .companies:
            return "Companies"
        case .shareApp:
            return "Share App"
        }
    }
        
        var iconName: String{
            switch self {
            case .aboutUs:
                return "house.fill"
            case .companies:
                return "building.fill"
            case .shareApp:
                return "square.and.arrow.up"
            }
        }
    }
