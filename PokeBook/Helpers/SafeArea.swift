//
//  SafeArea.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/23.
//

import SwiftUI

extension View {
    func safeArea() -> UIEdgeInsets {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero }
        guard let safeArea = scene.windows.first?.safeAreaInsets else { return .zero }
        return safeArea
    }
}
