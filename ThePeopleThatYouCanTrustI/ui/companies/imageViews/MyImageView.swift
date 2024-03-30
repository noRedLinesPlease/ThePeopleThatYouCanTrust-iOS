//
//  MyImageView.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/24/24.
//

import Foundation
import SwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader

    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
        print("init image loader CALLED")
    }

    var body: some View {
            Image(uiImage: imageLoader.image ?? UIImage() )
                .resizable()
                .imageScale(.small)
                .clipped()
                .padding(3)
                .frame(maxWidth: 160, alignment: .center)
        }
    }
                
