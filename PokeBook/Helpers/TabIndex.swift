//
//  TabBar.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/22.
//

import Foundation
import SwiftUI

enum TabIndex: Hashable {
    case home
    case liked
    
    var iconName: String {
        switch self {
        case .home: return "house"
        case .liked: return "heart"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "홈"
        case .liked: return "좋아요"
        }
    }
}

struct TabBarKey: PreferenceKey {
    static var defaultValue: [TabIndex] = []
    
    static func reduce(value: inout [TabIndex], nextValue: () -> [TabIndex]) {
        value += nextValue()
    }
}

struct TabBarHelper: ViewModifier {
    let tab: TabIndex
    @Binding var selection: TabIndex
    
    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1.0 : 0.0)
            .preference(key: TabBarKey.self, value: [tab])
    }
}

extension View {
    func tabBarHelper(tab: TabIndex, selection: Binding<TabIndex>) -> some View {
        self
            .modifier(TabBarHelper(tab: tab, selection: selection))
    }
}
