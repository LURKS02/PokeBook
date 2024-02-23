//
//  SafeBar.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/20.
//

import SwiftUI

struct SafeBar: View {
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .foregroundColor(Color.white)
                .ignoresSafeArea()
                .frame(height:0)
        }
    }
}

struct SafeBar_Previews: PreviewProvider {
    static var previews: some View {
        SafeBar()
    }
}
