//
//  NoNetworkView.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/22/24.
//

import SwiftUI

struct NoNetworkView : View {
    var body: some View {
        VStack {
            Image(
                "updatedLogo"
            )
            .resizable()
            .frame(width: 250, height: 250)
            
            Divider()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .overlay(.blue)
            Text("No internet connection detected.")
                .font(Font.custom("PermanentMarker-Regular", size: 30))
                .padding(.bottom, 8)
                .multilineTextAlignment(.center)
            Text("Please check connection and try again")
                .font(Font.custom("Truculenta-SemiBold", size: 28))
                .multilineTextAlignment(.center)
            Spacer()
        }.background(Color.darkModeOrNot)
    }
}
