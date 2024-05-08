//
//  CustomAlertView.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 4/24/24.
//

import SwiftUI

struct CustomAlert<Content: View>: View {
    
    let title: String
    let description: String
    
    var leftButtonAction: (() -> Void)
    var leftButtonTitle: String
    
   // var rightButtonAction: (() -> Void)
    var rightButtonTitle: String
    
    var onDismissFunc: (() -> Void)
    var customContent: Content?
    
    
        init(title: String,
             description: String,
             leftButtonAction: @escaping (() -> Void),
             leftButtonTitle: String,
            // rightButtonAction: @escaping (() -> Void),
             rightButtonTitle: String,
             onDismissFunc: @escaping (() -> Void),
             customContent: Content? = EmptyView()
        ) {
            self.title = title
            self.description = description
            self.leftButtonAction = leftButtonAction
            self.leftButtonTitle = leftButtonTitle
           // self.rightButtonAction = rightButtonAction
            self.rightButtonTitle = rightButtonTitle
            self.onDismissFunc = onDismissFunc
            self.customContent = customContent
        }
    
    @State var shouldDismiss: Bool = true
    
    var body: some View {
        HStack {
            VStack(spacing: 0) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .padding(.top)
                    .padding(.bottom, 8)
                
                Text(description)
                    .font(.system(size: 14, weight: .light, design: .default))
                    .multilineTextAlignment(.center)
                    .padding([.bottom, .trailing, .leading])
                
                customContent
                
                Divider()
                HStack {
                    Button { leftButtonAction() } label: {
                        Text(leftButtonTitle)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            .bold()
                            .foregroundStyle(.blue)
                    }
                    
                    Button {} label: {
                        Text(rightButtonTitle)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            .bold()
                            .foregroundStyle(.blue)
                            .onTapGesture {
                               onDismissFunc()
                                //viewModel.navigationManager.pageSelection.send(.searchCompanies)
                            }
                    }
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: 50,
                    alignment: .center
                )
                
            }
            .frame(minWidth: 0, maxWidth: 400, alignment: .center)
            .background(.ultraThickMaterial)
        }
        .zIndex(1)
        .cornerRadius(20)
        .frame( alignment: .center)
        .padding([.horizontal, .bottom], 0)
        .background(
            .clear
        )
    }
}
