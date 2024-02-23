//
//  Response+PokemonPagination.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/25.
//

import Foundation

struct PokemonPaginationResponse: Codable {
    var next: URL?
    var previous: URL?
    var results: [NameURLResponse]
}
