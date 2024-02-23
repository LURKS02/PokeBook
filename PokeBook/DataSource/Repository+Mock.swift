//
//  Repository+Mock.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/25.
//

import Foundation
import Combine

struct MockRepository: PokeRepository {
    
    func fetchPokemon(id: Int) -> AnyPublisher<Pokemon, Never> {
        Just<Pokemon>(
            .init(
                id: -1,
                name: "테스트 - 메타몽",
                genera: "테스트 - 변신 포켓몬",
                height: 0,
                weight: 0,
                dotFrontDefault: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png"),
                officialFrontDefault: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/132.png"),
                officialFrontShiny: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/132.png"),
                types: ["노말"],
                versionPokemonImages: [.init(version: "",
                                             frontDefault: nil,
                                             frontShiny: nil,
                                             backDefault: nil,
                                             backShiny: nil)],
                stats: [
                    .init(name: "테스트 스텟",
                          baseStat: 0)
                ],
                flavorTextEntries: [
                    .init(
                        flavorText: "테스트 - 메타몽은 귀엽다",
                        version: "테스트 버전")
                ],
                abilities: [
                    .init(
                        name: "테스트 능력",
                        flavorText: "테스트다.",
                        is_hidden: false)
                ])
        )
        .eraseToAnyPublisher()
    }
    
    func fetchPokeSpecies(id: Int) -> AnyPublisher<PokeSpeciesResponse, Never> {
        Just<PokeSpeciesResponse>(
            .init(
                flavor_text_entries: [
                    .init(
                        flavor_text: "테스트 문구",
                        language: .init(
                            name: "테스트 언어",
                            url: URL(string: "")!
                        ),
                        version: .init(
                            name: "테스트 버전",
                            url: URL(string: "")!
                        )
                    )],
                names: [
                    .init(
                        language: .init(
                            name: "테스트 언어",
                            url: URL(string: "")!
                        ),
                        name: "테스트 이름")
                ],
                genera: [
                    .init(
                        language: .init(
                            name: "테스트 언어",
                            url: URL(string: "")!
                        ),
                        genus: "테스트 종족")
                ]))
        .eraseToAnyPublisher()
    }
    
    func fetchPokemonPagination(nextURL: URL) -> AnyPublisher<PokemonPagination, Never> {
        Just<PokemonPagination>(
            .init(id: UUID(),
                  next: nil,
                  previous: nil,
                  pokeList: []))
        .eraseToAnyPublisher()
    }
    
    func searchPokemon(query: String) -> AnyPublisher<PokemonPagination, Never> {
        Just<PokemonPagination>(
            .init(id: UUID(),
                  next: nil,
                  previous: nil,
                  pokeList: []
                 )
        )
        .eraseToAnyPublisher()
    }
    
}
