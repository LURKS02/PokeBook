//
//  EllipsisButton.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/20.
//

import SwiftUI

struct EllipsisButton: View {
    var body: some View {
        Button(action: {}) {
            Image(systemName: "ellipsis")
                .foregroundColor(.black)
        }
    }
}

struct EllipsisButton_Previews: PreviewProvider {
    static var previews: some View {
        EllipsisButton()
    }
}
