//
//  ShareAppView.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 4/17/24.
//

import SwiftUI
import AlertToast

struct ShareAppView : View {
    @Environment(\.openURL) private var openURL
    @State private var iOSAppLink = "https://apps.apple.com/us/app/thepeoplethatyoucantrust/id6479319870"
    @State private var androidAppLink = "https://play.google.com/store/apps/details?id=cornhole.beanbag.thepeopleyoucantrust"
    @State private var copyButtonClicked = false
    var toastStyle = AlertToast.AlertStyle.style(backgroundColor: .appLinkDarkOrNot, titleColor: .blue)
    
    var body: some View {
        ScrollView {
            VStack() {
                Image("updatedLogo")
                    .resizable()
                    .frame(width: 160, height: 160)
                
                Text("Let other people know about TPTYCT!")
                    .font(Font.custom("BungeeSpice-Regular", size: 26))
                //.padding(.bottom, 8)
                    .multilineTextAlignment(.center)
                
                Divider()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .overlay(.blue)
                
                Text("Easily share the app with anyone by copying the direct app link below!")
                    .font(Font.custom("SansitaSwashed-SemiBold", size: 22))
                //.padding(.bottom, 8)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color(hex: "#45C0C6"))
                
                HStack() {
                    Image("iOSIcon").resizable().frame(width: 40, height: 40)
                    
                    Text("iOS")
                        .font(Font.custom("Truculenta-SemiBold", size: 50))
                        .foregroundStyle(Color(hex: "#45C0C6"))
                }
                .background(Color.darkModeOrNot)
                
                HStack() {
                    Text(iOSAppLink)
                        .font(.system(size: 13))
                        .bold()
                        .foregroundStyle(Color.sideMenuTextDark)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        UIPasteboard.general.setValue(iOSAppLink, forPasteboardType:"public.plain-text")
                        copyButtonClicked = true
                    }) {
                        Image(systemName: "doc.on.doc")
                            .foregroundStyle(Color(hex: "#45C0C6"))
                            .imageScale(.large)
                    }
                }
                
                HStack() {
                    Image("androidIcon")
                        .resizable()
                        .frame(width: 40, height: 40)
                    
                    Text("Android")
                        .font(Font.custom("Truculenta-SemiBold", size: 50))
                        .foregroundStyle(Color(hex: "#45C0C6"))
                }
                HStack {
                    Text(androidAppLink)
                        .font(.system(size: 13))
                        .bold()
                        .foregroundStyle(Color.sideMenuTextDark)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        UIPasteboard.general.setValue(androidAppLink, forPasteboardType:"public.plain-text")
                        copyButtonClicked = true
                    }) {
                        Image(systemName: "doc.on.doc")
                            .foregroundStyle(Color(hex: "#45C0C6"))
                            .imageScale(.large)
                    }
                }
                
            }
            .toast(isPresenting: $copyButtonClicked) {
                AlertToast(
                    displayMode: .banner(AlertToast.BannerAnimation.pop),
                    type: .regular,
                    title: "Link copied to clipboard",
                    style: toastStyle
                )
            }
            .background(Color.darkModeOrNot)
        }
    }
}
