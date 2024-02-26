//
//  VersionTag.swift
//  PokeBook
//
//  Created by 디해 on 2023/04/16.
//

import SwiftUI

struct VersionModifier: ViewModifier {
    var versionColor: String
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(Color(hexString: versionColor, opacity: 1.0))
            .foregroundColor(Color(hexString: versionColor).brightness() > 0.5 ? Color.black : Color.white)
            .cornerRadius(5)
    }
}

extension Color {
    func brightness() -> CGFloat {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
        UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: nil)
        return (red * 299 + green * 587 + blue * 114) / 1000
    }
}

extension View {
    func versionTag(versionColor: String) -> some View {
        modifier(VersionModifier(versionColor: versionColor))
    }
}
