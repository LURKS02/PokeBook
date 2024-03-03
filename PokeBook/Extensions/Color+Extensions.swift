//
//  Color+Extensions.swift
//  PokeBook
//
//  Created by 디해 on 3/3/24.
//

import SwiftUI

extension Color {
    static func get(_ appColor: AppColor) -> Color {
        let uiColor = UIColor.init { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .light:
                return appColor.light
            case .dark:
                return appColor.dark
            default:
                return appColor.light
            }
        }
        
        return Color(uiColor)
    }
}
