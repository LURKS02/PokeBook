//
//  Offset.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/19.
//

import SwiftUI

extension View {
    func offsetHelper(_ changeDirection: @escaping (CGFloat, CGFloat) -> ()) -> some View {
        self.modifier(OffsetHelper(changeDirection: changeDirection))
    }
}

struct OffsetHelper: ViewModifier {
    var changeDirection: (CGFloat, CGFloat) -> ()
    @State var previousOffset: CGFloat = 0
    @State var currentOffset: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { proxy in
                    let offsetY = proxy.frame(in: .global).origin.y
                    Color.clear
                        .preference(key: ScrollOffsetKey.self, value: offsetY)
                        .onPreferenceChange(ScrollOffsetKey.self) { offset in
                            previousOffset = currentOffset
                            currentOffset = offset
                            changeDirection(previousOffset, currentOffset)
                        }
                }
            }
    }
}

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
