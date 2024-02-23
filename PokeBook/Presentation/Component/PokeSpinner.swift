//
//  PokeSpinner.swift
//  PokeBook
//
//  Created by 디해 on 2023/04/17.
//

import SwiftUI

struct PokeSpinner: View {
    @State private var rotation = 0.0
    
    var body: some View {
        Image("pokeball")
            .resizable()
            .frame(width: 70, height: 70)
            .shadow(radius: 1)
            .rotationEffect(.degrees(rotation))
            .onAppear {
                DispatchQueue.main.async {
                    withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                        rotation = 360
                    }
                }
            }
    }
}

struct PokeSpinner_Previews: PreviewProvider {
    static var previews: some View {
        PokeSpinner()
    }
}
