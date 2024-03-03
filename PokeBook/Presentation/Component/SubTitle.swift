//
//  SubTitle.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/26.
//

import SwiftUI

struct SubTitle: View {
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(Color.get(.text(.secondary)))
            Spacer()
        }
    }
}

struct SubTitle_Previews: PreviewProvider {
    static var previews: some View {
        SubTitle(title: "부 타이틀")
    }
}
