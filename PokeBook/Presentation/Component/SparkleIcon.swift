//
//  SparkleIcon.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/02.
//

import SwiftUI

struct SparkleIcon: View {
    @Binding var isSparkle: Bool
    
    var body: some View {
        Image(systemName: "sparkles")
            .resizable()
            .frame(width: 15, height: 20)
            .padding(7)
            .foregroundColor(Color.get(.background(.screen)))
            .background(){
                Circle()
                    .fill(isSparkle ? Color.get(.button(.shinyBackgroundOn)) : Color.get(.button(.shinyBackgroundOff)))
            }
            .animation(.easeInOut(duration: 0.3), value: isSparkle)
    }
}
