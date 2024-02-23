//
//  PokeRepository.swift
//  PokeBook
//
//  Created by 디해 on 2023/03/20.
//

import Foundation
import Combine

protocol PokeRepository {
    // same function name, but it is allowed. -> method overloading.
    // method override -> same function. but it is overwritten.
    func fetchPokemon(id: Int) -> AnyPublisher<Pokemon, Never>
    func fetchPokeSpecies(id: Int) -> AnyPublisher<PokeSpeciesResponse, Never>
    func fetchPokemonPagination(nextURL: URL) -> AnyPublisher<PokemonPagination, Never>
    func searchPokemon(query: String) -> AnyPublisher<PokemonPagination, Never>
}

/*
 override
 
 class Parent {
 func hi() {
 print("i'm parent")
 }
 }
 
 class Child: Parent {
 @override
 func hi() {
 print("i'm child")
 }
 }
 */
