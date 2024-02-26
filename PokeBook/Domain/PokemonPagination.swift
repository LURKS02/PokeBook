//
//  PokeList.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/04.
//

import Foundation

struct PokemonPagination: Identifiable {
    var id: UUID
    var next: URL?
    var previous: URL?
    var pokeList: [PokemonCell]
}
