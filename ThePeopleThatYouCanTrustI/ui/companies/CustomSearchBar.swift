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
                
                TextField("Search", text: $searchText)
                    .focused($isFocused, equals: true)
                    .onChange(
                        of: isFocused,
                        perform: { value in
                        self.showCancelButton = isFocused
                    })
                    .foregroundColor(.black)
                    .onSubmit {
                        isFocused = false
                    }
                    .autocorrectionDisabled()
                Button(action: {
                    self.searchText = ""

                }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                }
            }
            .onAppear { self.kGuardian.addObserver() }
                .onDisappear { self.kGuardian.removeObserver() }

            
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(Color.blue)
            .background(.white)
            .cornerRadius(10.0)
            
            if showCancelButton  {
                Button("Cancel") {
                    self.showCancelButton = false
                    self.searchText = ""
                    isFocused = false
                    print("Hit Cancel")
                    
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
        .padding(.horizontal)
        //.navigationBarHidden(showCancelButton)
    }
    
    func getIsFocused() -> Bool {
        return self.isFocused
    }
}
