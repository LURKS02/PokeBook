//
//  Response+PokemonAbilities.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/25.
//

import Foundation

struct PokeAbilitiesResponse: Codable {
    var flavor_text_entries: [FlavorTextEntriesResponse]
    var names: [NameResponse]
    
    struct FlavorTextEntriesResponse: Codable, LanguageSupport {
        var flavor_text: String
        var language: NameURLResponse
        var version_group: NameURLResponse
    }
    
    struct NameResponse: Codable, LanguageSupport {
        var language: NameURLResponse
        var name: String
    }
}
