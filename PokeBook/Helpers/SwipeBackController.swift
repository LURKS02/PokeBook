//
//  SwipeBackController.swift
//  PokeBook
//
//  Created by 디해 on 3/10/24.
//

import SwiftUI
import UIKit

struct SwipeBackController<Content: View>: UIViewControllerRepresentable {
    let rootView: Content

    init(@ViewBuilder content: () -> Content) {
        self.rootView = content()
    }

    func makeUIViewController(context: Context) -> UINavigationController {
        let rootVC = UIHostingController(rootView: rootView)
        let navController = UINavigationController(rootViewController: rootVC)
        navController.interactivePopGestureRecognizer?.delegate = nil
        return navController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    }
}
