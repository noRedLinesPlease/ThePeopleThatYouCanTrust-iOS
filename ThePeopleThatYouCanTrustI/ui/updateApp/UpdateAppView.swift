//
//  PleaseUpdateAppView.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 4/20/24.
//

import SwiftUI

struct AppUpateAlertView : View {
    var body: some View {
        VStack {
            Image("updatedLogo")
                .resizable()
                .frame(width: 250, height: 250)
        }
        .overlay {
            CustomAlert (
                title: "Update required",
                description: "Please update app to continue enjoying our app!",
                buttonAction: {
                    let url = URL(string: "https://apps.apple.com/us/app/thepeoplethatyoucantrust/id6479319870")!
                    UIApplication.shared.open(url)
                },
                buttonTitle: "Update"
            )
        }
        .transition(.scale)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.darkModeOrNot)
    }
}

