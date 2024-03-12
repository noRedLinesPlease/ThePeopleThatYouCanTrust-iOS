//
//  InjectionAnn.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/10/24.
//

import Foundation
import Combine


@propertyWrapper
struct Injection<T> {

  private let keyPath: WritableKeyPath<InjectedDependency, T>

  var wrappedValue: T {
    get { InjectedDependency[keyPath] }
    set { InjectedDependency[keyPath] = newValue }
  }

  init(_ keyPath: WritableKeyPath<InjectedDependency, T>) {
    self.keyPath = keyPath
  }
}

protocol InjectedKeyProtocol {
  associatedtype Value
  static var currentValue: Self.Value { get set }
}

struct InjectedDependency {

  private static var current = InjectedDependency()

  static subscript<K>(key: K.Type) -> K.Value where K: InjectedKeyProtocol {
    get { key.currentValue }
    set { key.currentValue = newValue }
  }

  static subscript<T>(_ keyPath: WritableKeyPath<InjectedDependency, T>) -> T {
    get { current[keyPath: keyPath] }
    set { current[keyPath: keyPath] = newValue }
  }
}

extension InjectedDependency {

  var navigationManager: NavigationManagerProtocol {
    get { Self[NavigationManagerKey.self] }
    set { Self[NavigationManagerKey.self] = newValue }
  }
}

private struct NavigationManagerKey: InjectedKeyProtocol {
  static var currentValue: NavigationManagerProtocol = NavigationManager()
}

