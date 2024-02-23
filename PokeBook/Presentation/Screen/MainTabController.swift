//
//  MainTabScreen.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/22.
//

import SwiftUI

struct MainTabController<Content:View>: View {
    @State private var tabs: [TabIndex] = []
    @State private var tabViewHeight: CGFloat = 0
    @Binding var selection: TabIndex
    let content: Content

    init(selection: Binding<TabIndex>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .padding(.bottom, tabViewHeight)
            
            SafeBar()
            
            MainTabView(tabs: tabs, selection: $selection)
                .heightHelper { height in
                    tabViewHeight = height
                }
        }
        .onPreferenceChange(TabBarKey.self) { value in
            self.tabs = value
        }
    }
}

struct MainTabController_Previews: PreviewProvider {

    static var previews: some View {
        MainTabController(selection: .constant(.home)) {
            Color.gray
        }
    }
}
