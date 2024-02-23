//
//  MainTabView.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/22.
//

import SwiftUI

struct MainTabView: View {
    let tabs: [TabIndex]
    @Binding var selection: TabIndex
    
    var body: some View {
        tabBar
    }
    
    private var tabBar: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        switchTab(tab: tab)
                    }
            }
        }
        .padding(.top, 10)
        .background(Color.white.edgesIgnoringSafeArea(.bottom)
            .shadow(color: .gray.opacity(0.3), radius: 2))
    }
    
    private func switchTab(tab: TabIndex) {
        selection = tab
    }
}

extension MainTabView {
    private func tabView(tab: TabIndex) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)
            Text(tab.title)
                .font(.system(size: 11))
        }
        .frame(maxWidth: .infinity)
        .foregroundColor(selection == tab ? Color.black : Color.gray)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static let tabs:[TabIndex] = [.home, .liked]
    
    static var previews: some View {
        VStack {
            Spacer()
            MainTabView(tabs: tabs, selection: .constant(tabs.first!))
        }
        .background(Color.indigo)
    }
}
