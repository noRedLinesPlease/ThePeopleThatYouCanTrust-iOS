//
//  SidebarRowType.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/10/24.
//

enum SideBarRowType: Int, CaseIterable {
    case aboutUs = 0
    case searchCompanies = 1
    case allCompanies = 2
    case shareApp = 3
    
    var title: String{
        switch self {
        case .aboutUs:
            return "About Us"
        case .searchCompanies:
            return "Search Companies"
        case .allCompanies:
            return "Browse All Companies"
        case .shareApp:
            return "Share App"
        }
    }
        
        var iconName: String{
            switch self {
            case .aboutUs:
                return "info.circle.fill"
            case.searchCompanies:
                return "magnifyingglass"
            case .allCompanies:
                return "building.fill"
            case .shareApp:
                return "square.and.arrow.up"
            }
        }
    }
