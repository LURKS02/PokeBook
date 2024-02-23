//
//  SimpleLine.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/26.
//

import SwiftUI

struct SimpleLine: View {
    var height: CGFloat
    var opacity: CGFloat
    
    init(height: CGFloat = 1,
         opacity: CGFloat = 0.2) {
        self.height = height
        self.opacity = opacity
    }
    
    var body: some View {
        Rectangle()
            .fill(Color.gray.opacity(opacity))
            .frame(height:height)
    }
}

struct SimpleLine_Previews: PreviewProvider {
    static var previews: some View {
        SimpleLine()
    }
}
