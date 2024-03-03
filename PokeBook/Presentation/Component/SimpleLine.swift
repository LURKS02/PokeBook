//
//  SimpleLine.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/26.
//

import SwiftUI

struct SimpleLine: View {
    private var height: CGFloat
    
    init(height: CGFloat = 1) {
        self.height = height
    }
    
    var body: some View {
        Rectangle()
            .fill(Color.get(.background(.line)))
            .frame(height:height)
    }
}

struct SimpleLine_Previews: PreviewProvider {
    static var previews: some View {
        SimpleLine()
    }
}
