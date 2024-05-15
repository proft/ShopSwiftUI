//
//  ImageSlider.swift
//  ShopSwiftUI
//
//  Created by Ivan Morgun on 15.05.2024.
//

import SwiftUI

struct ImageSlider: View {
    var images: [String]
    
    var body: some View {
        TabView {
            ForEach(images, id: \.self) { url in
                AsyncImage(url: URL(string: url)) { img in
                    img.resizable().scaledToFill()
                } placeholder: {
                    ProgressView()
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}
