//
//  PokeRepo+Real.swift
//  PokeBook
//
//  Created by 디해 on 2023/03/20.
//

import Foundation
import Combine

// 레포의 책임은 무엇일까?
// 데이터를 받아서 도메인 모델로 바꿔주는 책임.

// 리얼 레포의 책임은 무엇일까?
// 실제 서버에서 데이터를 가져온다. + 레포의 역할있다.
class RealPokeRepository: PokeRepository {
    /*
     func fetchPokesPublisher() -> AnyPublisher<Poke, Never> {
     let url = URL(string: "https://pokeapi.co/api/v2/pokemon/ditto")!
     return URLSession.shared.dataTaskPublisher(for: url)
     .subscribe(on: DispatchQueue.global(qos: .background))
     .tryMap { data, response in
     guard
     let response = response as? HTTPURLResponse,
     response.statusCode == 200 else {
     throw URLError(.badServerResponse)
     }
     return data
     }
     .decode(type: PokeResponseItem.self, decoder: JSONDecoder())
     .map { $0.toDomainModel() }
     .assertNoFailure()
     .eraseToAnyPublisher()
     }*/
    
    /*func fetchPokeDetail(idOrName: String) -> AnyPublisher<Poke, Never> {
     // URL -> URL Only (ex: https://myChemicalRomance.com/)
     let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(idOrName)")!
     
     // URL Request -> Method, Query Parameter, Header all of them.
     let urlRequest = URLRequest(url: url)
     
     
     // syncly call
     return Publishers.CombineLatest(
     URLSession.shared.makeURLPublisher(urlRequest, decodedType: PokeResponse.self),
     fetchPokeSpecies(idOrName: idOrName)
     )
     .print()
     .map { poke, species in
     return Poke(
     id: poke.id,
     name: species.names.getLocalized()[0].name,
     genera: species.genera.getLocalized()[0].genus,
     height: poke.height,
     weight: poke.weight,
     dotFrontDefault: poke.sprites.front_default,
     officialFrontDefault: poke.sprites.other.official_artwork.front_default,
     officialFrontShiny: poke.sprites.other.official_artwork.front_shiny,
     types: poke.types.map { $0.type.name },
     stats: poke.stats.map {
     Poke.Stats(name: $0.stat.name, baseStat: $0.base_stat)},
     flavorTextEntries: species.flavor_text_entries
     .getLocalized()
     .map { Poke.FlavorTextEntries(
     flavorText: $0.flavor_text.replacingOccurrences(of: "\n", with: " "),
     version: $0.version.name)}
     )
     }
     .eraseToAnyPublisher()
     
     // orderly call
     /*
      return URLSession.shared.makeURLPublisher(urlRequest, decodedType: PokeResponseItem.self)
      .flatMap { response -> AnyPublisher<SpeciesResponse, Never> in
      pokeResponse = response
      
      let url = URL(string: response.species.url)!
      let urlRequest = URLRequest(url: url)
      
      return URLSession.shared.makeURLPublisher(urlRequest, decodedType: SpeciesResponse.self)
      }
      .map { speciesResposne -> Poke in
      return .init(
      id: pokeResponse!.id,
      name: pokeResponse!.name,
      species: .init(name: speciesResposne.name)
      )
      }
      .eraseToAnyPublisher()
      */
     }*/
    
    func fetchPokemon(id: Int) -> AnyPublisher<Pokemon, Never> {
        // URL -> URL Only (ex: https://myChemicalRomance.com/)
        
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!
        
        // URL Request -> Method, Query Parameter, Header all of them.
        let urlRequest = URLRequest(url: url)
        
        // syncly call
        return Publishers.CombineLatest(
            URLSession.shared.makeURLPublisher(urlRequest, decodedType: PokemonResponse.self),
            fetchPokeSpecies(id: id)
        )
        .flatMap { pokeResponse, speciesResponse -> AnyPublisher<(PokemonResponse, PokeSpeciesResponse, [PokeAbilitiesResponse]), Never> in
            let abilityURLs = pokeResponse.abilities.map { $0.ability.url }
            let abilityRequests = abilityURLs.map { URLRequest(url: $0) }
            return URLSession.shared.makeMultipleURLPublisher(abilityRequests, decodedType: PokeAbilitiesResponse.self)
                .map { abilitiesResponses in
                    (pokeResponse, speciesResponse, abilitiesResponses)
                }
                .eraseToAnyPublisher()
        }
        .map { pokeResponse, speciesResponse, abilitiesResponses in
            
            let totalStat = pokeResponse.stats.reduce(0, { $0 + $1.base_stat})
            let totalStatObject = Pokemon.Stats(name: "total", baseStat: totalStat)
            var stats = pokeResponse.stats
                .map { Pokemon.Stats(name: $0.stat.name, baseStat: $0.base_stat)}
            stats.insert(totalStatObject, at: 0)
            
            let versionOrder = ["red-blue", "yellow", "crystal", "gold", "silver", "emerald", "firered-leafgreen", "ruby-sapphire", "diamond-pearl", "heartgold-soulsilver", "platinum", "black-white", "omegaruby-alphasapphire", "ultra-sun-ultra-moon", "x-y"]
            var orderedPokemonImages: [Pokemon.PokemonImage] = []
            
            for version in versionOrder {
                for (_, versionDictionary) in pokeResponse.sprites.versions {
                    if let sprite = versionDictionary[version] {
                        let values = [sprite.frontDefault, sprite.frontShiny, sprite.backDefault, sprite.backShiny]
                        if !values.compactMap({$0}).isEmpty {
                            orderedPokemonImages.append(.init(version: version, frontDefault: sprite.frontDefault ?? nil, frontShiny: sprite.frontShiny ?? nil, backDefault: sprite.backDefault ?? nil, backShiny: sprite.backShiny ?? nil))
                        }
                    }
                }
            }
            
            let abilities = abilitiesResponses.enumerated().map { (index, abilitiesResponse) -> Pokemon.Abilities in
                
                var flavorText = ""
                if let firstEntry = abilitiesResponse.flavor_text_entries.getLocalized().first {
                    flavorText = firstEntry.flavor_text.replacingOccurrences(of: "\n", with: " ")
                }
                return Pokemon.Abilities(
                    name: abilitiesResponse.names.getLocalized()[0].name,
                    flavorText: flavorText,
                    is_hidden: pokeResponse.abilities[index].is_hidden
                )
            }
            
            return Pokemon(
                id: pokeResponse.id,
                name: speciesResponse.names.getLocalized()[0].name,
                genera: speciesResponse.genera.getLocalized()[0].genus,
                height: pokeResponse.height,
                weight: pokeResponse.weight,
                dotFrontDefault: pokeResponse.sprites.front_default,
                officialFrontDefault: pokeResponse.sprites.other.official_artwork.front_default,
                officialFrontShiny: pokeResponse.sprites.other.official_artwork.front_shiny,
                types: pokeResponse.types.map { $0.type.name },
                versionPokemonImages: orderedPokemonImages,
                stats: stats,
                flavorTextEntries: speciesResponse.flavor_text_entries
                    .getLocalized()
                    .map { Pokemon.FlavorTextEntries(
                        flavorText: $0.flavor_text.replacingOccurrences(of: "\n", with: " "),
                        version: $0.version.name)},
                abilities: abilities
            )
        }
        .eraseToAnyPublisher()
    }
    
    func fetchPokeSpecies(id: Int) -> AnyPublisher<PokeSpeciesResponse, Never> {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(id)")!
        let urlRequest = URLRequest(url: url)
        
        return URLSession.shared.makeURLPublisher(urlRequest, decodedType: PokeSpeciesResponse.self)
        /*.map { Poke.Species(name: $0.name) }
         .eraseToAnyPublisher()*/
    }
    
    func fetchPokemonPagination(nextURL: URL) -> AnyPublisher<PokemonPagination, Never> {
        let urlRequest = URLRequest(url: nextURL)
        
        return URLSession.shared.makeURLPublisher(urlRequest, decodedType: PokemonPaginationResponse.self)
            .flatMap { pokeListResponse -> AnyPublisher<PokemonPagination, Never> in
                let pokeURLs = pokeListResponse.results.map { $0.url }
                let filteredPokeURLs = pokeURLs.filter { pokeURL in
                    if let pokeID = Int(pokeURL.absoluteString.split(separator: "/").last!) {
                        return pokeID <= 1010
                    }
                    return false
                }
                
                let pokeLists = filteredPokeURLs.map { pokeURL in
                    let pokeURLString = pokeURL.absoluteString
                    let pokeID = Int(pokeURLString.split(separator: "/").last!)!
                    
                    let pokeURLRequest = URLRequest(url: URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokeID)")!)
                    
                    return Publishers.CombineLatest(
                        URLSession.shared.makeURLPublisher(pokeURLRequest, decodedType: PokemonResponse.self),
                        self.fetchPokeSpecies(id: pokeID)
                    )
                    .map { pokeResponse, pokeSpeciesResponse in
                        return PokemonCell(id: pokeResponse.id,
                                                     name: pokeSpeciesResponse.names.getLocalized()[0].name,
                                                     genera: pokeSpeciesResponse.genera.getLocalized()[0].genus,
                                                     officialFrontDefault: pokeResponse.sprites.other.official_artwork.front_default,
                                                     dotFrontDefault: pokeResponse.sprites.front_default,
                                                     types: pokeResponse.types.map { $0.type.name })
                    }
                    .eraseToAnyPublisher()
                }
                
                
                return Publishers.MergeMany(pokeLists)
                    .collect()
                    .map { pokeListCells in
                        let sortedPokeListCells = pokeListCells.sorted { $0.id < $1.id }
                        return PokemonPagination(id: UUID(),
                                        next: pokeListResponse.next,
                                        previous: pokeListResponse.previous,
                                        pokeList: sortedPokeListCells)
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func searchPokemon(query: String) -> AnyPublisher<PokemonPagination, Never> {
        return fetchPokemonPagination(nextURL: URL(string: "https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0")!)
            .map { pokemons in
                let filteredPokemonCells = pokemons.pokeList.filter { pokemon in
                    return pokemon.name.contains(query)
                    
                }
                var filteredPokemons = pokemons
                filteredPokemons.pokeList = filteredPokemonCells
                return filteredPokemons
            }
            .eraseToAnyPublisher()
    }
}

extension URLSession {
    func makeMultipleURLPublisher<T: Decodable>(_ requests: [URLRequest], decodedType: T.Type) -> AnyPublisher<[T], Never> {
        let responses = Publishers.MergeMany(requests.map { self.makeURLPublisher($0, decodedType: decodedType) })
            .collect()
            .eraseToAnyPublisher()
        
        return responses
    }
}
