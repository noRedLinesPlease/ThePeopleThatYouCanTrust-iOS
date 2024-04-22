//
//  PleaseUpdateAppView.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 4/20/24.
//

import SwiftUI

struct AppUpateAlertView : View {
    @Binding var appNeedsToBeUpdated: Bool
    
    var body: some View {
        VStack {
            Image("updatedLogo")
                .resizable()
                .frame(width: 250, height: 250)
        }
        .onDisappear {
            appNeedsToBeUpdated = true
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.darkModeOrNot)
        .alert("Upate required", isPresented: $appNeedsToBeUpdated) {
            Button(action: {
                let url = URL(string: "https://apps.apple.com/us/app/thepeoplethatyoucantrust/id6479319870")!
                UIApplication.shared.open(url)
            }) {
                Text("Update")
            }
        } message: {  
            Text("Please update the app before continuining to enjoy the app!")
                .multilineTextAlignment(.center)
        }
        Spacer()
    }
}

