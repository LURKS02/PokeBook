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
            .foregroundColor(.white)
            .background(){
                Circle()
                    .fill(Color(hexString: isSparkle ? "5B5B5B" : "CACACA"))
            }
            .animation(.easeInOut(duration: 0.3), value: isSparkle)
    }
}
