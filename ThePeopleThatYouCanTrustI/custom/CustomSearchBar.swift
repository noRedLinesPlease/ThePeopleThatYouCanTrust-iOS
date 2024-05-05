//
//  CustomSearchBar.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/10/24.
//

import SwiftUI

struct CustomSearchBar : View {
    @Binding var searchText: String
    @State private var showCancelButton: Bool = false
    @ObservedObject private var kGuardian = KeyboardGuardian()
    @FocusState<Bool>.Binding var isFocused: Bool
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField(text: $searchText) {
                    if #available(iOS 17.0, *) {
                        Text("Search").foregroundStyle(.blue).padding(.leading, 4)
                    } else {
                        Text("Search").foregroundColor(.blue).padding(.leading, 6)
                    }
                }
                .focused($isFocused, equals: true)
                .onChange(
                    of: isFocused,
                    perform: { value in
                        self.showCancelButton = isFocused
                    })
                .foregroundStyle(Color.black)
                .onSubmit {
                    isFocused = false
                }
                .autocorrectionDisabled()
                Button(action: {
                    self.searchText = ""
                    
                }
                ) {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                }
                .buttonStyle(PlainButtonStyle())
                
            }
            .onAppear { self.kGuardian.addObserver() }
            .onDisappear { self.kGuardian.removeObserver() }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(Color.blue)
            .background(.white)
            .tint(Color.clear)
            .cornerRadius(10.0)
            
            if showCancelButton  {
                Button("Cancel") {
                    self.showCancelButton = false
                    self.searchText = ""
                    isFocused = false
                    print("Hit Cancel")
                    
                }
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(Color(.systemBlue))
                .background(Color.clear)
            }
        }
        .padding(.horizontal)
    }
    
    func getIsFocused() -> Bool {
        return self.isFocused
    }
}
