//
//  PokemonCellImageView.swift
//  PokeBook
//
//  Created by 디해 on 2024/02/11.
//

import SwiftUI

struct ImageSourceView: View {
    
    @State private var image: UIImage?
    @State private var imageOpacity: Double = 0
    
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .opacity(imageOpacity)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            imageOpacity = 1
                        }
                    }
            } else {
                Color.get(.background(.cell))
                    .scaledToFit()
            }
        }
        .onAppear {
            Task {
                image = await ImageCacheManager.shared.getImage(url: url)
            }
        }
    }
    
}
