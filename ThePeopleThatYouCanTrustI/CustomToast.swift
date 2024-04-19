//
//  CustomToast.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 4/19/24.
//

import SwiftUI

struct Toast: View {
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("TESTING")
            }.font(.headline)
                .foregroundColor(.primary)
                .padding([.top,.bottom],20)
                .padding([.leading,.trailing],40)
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(Capsule())
        }
        .frame(width: 25, height: 25)
        .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {}
            }
        })
    }
}
