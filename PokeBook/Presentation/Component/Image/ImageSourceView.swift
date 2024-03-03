//
//  PokemonCellImageView.swift
//  PokeBook
//
//  Created by 디해 on 2024/02/11.
//

import SwiftUI

struct ImageSourceView: View {
    
    @State private var image: UIImage?
    
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
            } else {
                Color.get(.background(.cell))
                    .frame(minHeight: 100)
            }
        }
        .onAppear {
            Task {
                image = await ImageCacheManager.shared.getImage(url: url)
            }
        }
    }
    
}
