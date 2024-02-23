//
//  Response+PokemonSpecies.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/25.
//

import Foundation

struct PokeSpeciesResponse: Codable {
    var flavor_text_entries: [FlavorTextEntriesResponse]
    var names: [NameResponse]
    var genera: [GeneraResponse]
    
    struct FlavorTextEntriesResponse: Codable, LanguageSupport {
        var flavor_text: String
        var language: NameURLResponse
        var version: NameURLResponse
    }
    
    struct NameResponse: Codable, LanguageSupport {
        var language: NameURLResponse
        var name: String
    }
    
    struct GeneraResponse: Codable, LanguageSupport {
        var language: NameURLResponse
        var genus: String
    }
}
