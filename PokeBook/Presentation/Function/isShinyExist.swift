//
//  isShinyExist.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/02.
//

import Foundation

func isShinyExist(pokemonImage: Pokemon.PokemonImage) -> Bool {
    return (pokemonImage.frontShiny != nil) || (pokemonImage.backShiny != nil)
}
