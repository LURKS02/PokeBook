//
//  Response+Language.swift
//  PokeBook
//
//  Created by 디해 on 2023/03/27.
//

import Foundation

// interface
protocol LanguageSupport {
    var language: NameURLResponse { get }
}

extension Array where Element: LanguageSupport {
    func getLocalized(_ locales: [String] = ["ko", "en", "ja-Hrkt"]) -> [Self.Element] {
        for locale in locales {
            let filtered = self.filter { $0.language.name == locale }
            if !filtered.isEmpty {
                return filtered
            }
        }
        return []
    }
}
