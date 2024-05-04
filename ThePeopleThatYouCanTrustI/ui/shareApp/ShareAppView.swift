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
    @State var whichAppLink = ""
    var toastStyle = AlertToast.AlertStyle.style(backgroundColor: .appLinkDarkOrNot, titleColor: .blue)
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 6) {
                Image("updatedLogo")
                    .resizable()
                    .frame(width: 160, height: 160)
                
                Text("Let other people know about TPTYCT!")
                    .font(Font.custom("BungeeSpice-Regular", size: 26))
                    .multilineTextAlignment(.center)
                
                Divider()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .overlay(.blue)
                
                Text("Easily share the app with anyone by scanning QR code or copying the app link below!")
                    .font(Font.custom("SansitaSwashed-SemiBold", size: 22))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color(hex: "#45C0C6"))
                
                HStack(spacing: 12) {
                    Image("iOSIcon").resizable().frame(width: 50, height: 50)
                    
                    Text("iOS")
                        .font(Font.custom("Truculenta-SemiBold", size: 50))
                        .foregroundStyle(Color.ios)
                    
                    Button(action: {
                        UIPasteboard.general.setValue(iOSAppLink, forPasteboardType:"public.plain-text")
                        whichAppLink = "iOS"
                        copyButtonClicked = true
                    }) {
                        Image(systemName: "doc.on.doc")
                            .font(.system(size: 30))
                            .foregroundStyle(Color(hex: "#45C0C6"))
                            .imageScale(.large)
                            .padding(.leading, 5)
                    }
                    
                }
                .padding(.top, 12)
                .background(Color.darkModeOrNot)
                
                Image("iOSQRCode")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 8)
                
                HStack(spacing: 12) {
                    Image("androidIcon")
                        .resizable()
                        .frame(width: 50, height: 50)
                    
                    Text("Android")
                        .font(Font.custom("Truculenta-SemiBold", size: 50))
                        .foregroundStyle(Color.android)
                    
                    Button(action: {
                        UIPasteboard.general.setValue(androidAppLink, forPasteboardType:"public.plain-text")
                        whichAppLink = "Android"
                        copyButtonClicked = true
                    }) {
                        Image(systemName: "doc.on.doc")
                            .font(.system(size: 30))
                            .foregroundStyle(Color(hex: "#45C0C6"))
                            .imageScale(.large)
                            .padding(.leading, 5)
                    }
                }
                Image("androidQRCode")
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            .toast(isPresenting: $copyButtonClicked) {
                AlertToast(
                    displayMode: .banner(AlertToast.BannerAnimation.pop),
                    type: .regular,
                    title: "Link copied to clipboard: \(whichAppLink)",
                    style: toastStyle
                )
            }
            .padding(.bottom, 10)
            .background(Color.darkModeOrNot)
        }
        .background(Color.darkModeOrNot)
    }
}
