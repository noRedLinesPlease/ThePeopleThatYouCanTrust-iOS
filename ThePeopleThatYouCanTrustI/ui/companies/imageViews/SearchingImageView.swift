//
//  SearchingImageView.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/24/24.
//

import Foundation
import SwiftUI

struct SearchImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    
    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }
    
    var body: some View {
        Image(uiImage: imageLoader.image ?? UIImage() )
            .resizable()
            .clipped()
            .padding(3)
            .frame(maxWidth: 60, maxHeight: 60, alignment: .center)
    }
}
