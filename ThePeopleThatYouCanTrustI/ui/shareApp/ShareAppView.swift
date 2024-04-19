//
//  ShareAppView.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 4/17/24.
//

import SwiftUI

struct ShareAppView : View {
    @Environment(\.openURL) private var openURL
    @State private var iOSAppLink = "https://apps.apple.com/us/app/thepeoplethatyoucantrust/id6479319870"
    @State private var isLinkVisible = false
    
    
    var body: some View {
        if(isLinkVisible) {
            Toast()
           
        }
        VStack {
            Image(
                "updatedLogo"
            )
            .resizable()
            .frame(width: 250, height: 250)
            
            Divider()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .overlay(.blue)
            Text("Share the app with your friends!")
                .font(Font.custom("PermanentMarker-Regular", size: 30))
                .padding(.bottom, 8)
                .multilineTextAlignment(.center)
            HStack {
                Text(isLinkVisible ?  "Copy iOS App" : "Click to share iOS App"  )
                    .font(Font.custom("Truculenta-SemiBold", size: 28))
                    .multilineTextAlignment(.center)
                    .onTapGesture {
                        isLinkVisible = true
                        //UIApplication.shared.open((URL(string: iOSAppLink)!), options:[:], completionHandler: nil)
                    }
                Button(action: {
                    UIPasteboard.general.setValue(iOSAppLink, forPasteboardType:"public.plain-text")
                    
                }
                ) {
                    Image(systemName: isLinkVisible ?  "doc.on.doc" : "").foregroundStyle(.black)
                }
            }
            Text(isLinkVisible ? iOSAppLink : "")
                .background(Color.appLinkDarkOrNot)
                .font(.system(size: 12))
                .bold()
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .background(Color.darkModeOrNot)
    }
}
