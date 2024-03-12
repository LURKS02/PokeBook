//
//  MainTabScreen.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/23.
//

import SwiftUI

struct MainTabScreen: View {
    @State private var selection: TabIndex = .home
    
    var body: some View {
        SwipeBackController {
            MainTabController(selection: $selection) {
                PokemonListScreen()
                    .tabBarHelper(tab: .home, selection: $selection)
                
                LikedPokeListScreen(selection: $selection)
                    .tabBarHelper(tab: .liked, selection: $selection)
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .navigationBarHidden(true)
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct MainTabScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainTabScreen()
    }
}
