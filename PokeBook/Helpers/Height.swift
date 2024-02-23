//
//  Height.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/20.
//

import SwiftUI

extension View {
    func heightHelper(_ heightFunc: @escaping (CGFloat) -> ()) -> some View {
        self
            .modifier(HeightHelper(heightFunc: heightFunc))
    }
}

struct HeightHelper: ViewModifier {
    var heightFunc: (CGFloat) -> ()
    @State var height: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { proxy in
                    Color.clear.preference(key: ViewHeightKey.self, value: proxy.size.height)
                        .onPreferenceChange( ViewHeightKey.self) { value in
                            height = value
                            heightFunc(value)
                        }
                }
            }
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
