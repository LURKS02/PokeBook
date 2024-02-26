//
//  MockedData.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/09.
//

import Foundation

extension Pokemon {
    static let mockedData: Pokemon =
    Pokemon(id: 1,
            name: "이상해씨",
            genera: "씨앗포켓몬",
            height: 7,
            weight: 69,
            types: ["grass", "poison"],
            versionPokemonImages: [],
            stats: [],
            flavorTextEntries: [],
            abilities: [])
}

extension PokemonPagination {
    
    static let mockedData: PokemonPagination =
    PokemonPagination(id: UUID(),
             next: nil,
             previous: nil,
             pokeList: [PokemonCell(
                                     id: 1,
                                     name: "이상해씨",
                                     genera: "씨앗포켓몬",
                                     officialFrontDefault: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png")!,
                                     dotFrontDefault: URL(string:"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")!,
                                     types: ["grass", "poison"])
             ]
    )
}
