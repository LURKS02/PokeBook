//
//  PokemonCell.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/24.
//

import Foundation

struct PokemonCell: Hashable, Identifiable {
    var id: Int
    var name: String
    var genera: String
    var officialFrontDefault: URL?
    var dotFrontDefault: URL?
    var types: [String]
}

extension PokemonCell {
    var dictionaryValue: [String: Any] {
        [
            "id": Int16(id),
            "name": name,
            "genera": genera,
            "officialFrontDefault": officialFrontDefault?.absoluteString ?? "",
            "dotFrontDefault": dotFrontDefault?.absoluteString ?? "",
            "types": types
        ]
    }
}
