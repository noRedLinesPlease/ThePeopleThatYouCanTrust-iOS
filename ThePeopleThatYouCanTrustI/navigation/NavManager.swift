//
//  NavManager.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/10/24.
//


import Foundation
import Combine

final class NavigationManager: NavigationManagerProtocol, ObservableObject {

  @Published var pageSelection = CurrentValueSubject<SideBarRowType, Never>(.home)
}

protocol NavigationManagerProtocol {
  var pageSelection: CurrentValueSubject<SideBarRowType, Never> { get set }
}
