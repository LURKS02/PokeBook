//
//  PokeDomain.swift
//  PokeBook
//
//  Created by 디해 on 2023/03/20.
//

import Foundation

// 도메인 모델(엔티티) -> 앱 안에서 사용되는 데이터
// 앱이 관심 있는 데이터만 담그는게 좋다.
struct Pokemon: Identifiable {
    var id: Int
    var name: String
    var genera: String
    var height: Int
    var weight: Int
    var dotFrontDefault: URL?
    var officialFrontDefault: URL?
    var officialFrontShiny: URL?
    var types: [String]
    
    var versionPokemonImages: [PokemonImage]
    var stats: [Stats]
    var flavorTextEntries: [FlavorTextEntries]
    var abilities: [Abilities]

    struct Stats: Hashable {
        var name: String
        var baseStat: Int
    }
    
    struct FlavorTextEntries: Hashable {
        var flavorText: String
        var version: String
    }
    
    struct Abilities: Hashable {
        var name: String
        var flavorText: String
        var is_hidden: Bool
    }
    
    struct PokemonImage: Hashable {
        var version: String
        var frontDefault: URL?
        var frontShiny: URL?
        var backDefault: URL?
        var backShiny: URL?
    }
}

extension Pokemon {
    func convertToCell() -> PokemonCell {
        PokemonCell(id: self.id,
                    name: self.name,
                    genera: self.genera,
                    officialFrontDefault: self.officialFrontDefault,
                    dotFrontDefault: self.dotFrontDefault,
                    types: self.types)
    }
}
