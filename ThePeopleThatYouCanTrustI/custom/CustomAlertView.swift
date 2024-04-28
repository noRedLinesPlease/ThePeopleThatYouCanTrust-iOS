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
    
    var buttonAction: (() -> Void)
    var buttonTitle: String
    
    var customContent: Content?
    
    init(title: String,
         description: String,
         buttonAction: @escaping (() -> Void),
         buttonTitle: String,
         customContent: Content? = EmptyView()) {
        self.title = title
        self.description = description
        self.buttonAction = buttonAction
        self.buttonTitle = buttonTitle
        self.customContent = customContent
    }
    
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
                        Button { buttonAction() } label: {
                            Text(buttonTitle)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                                .bold()
                                .foregroundStyle(.blue)
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
