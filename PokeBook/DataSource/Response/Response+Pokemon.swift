//
//  PokeData.swift
//  PokeBook
//
//  Created by 디해 on 2023/03/20.
//

import Foundation
import Combine

struct PokemonResponse: Codable {
    var id: Int
    var height: Int
    var weight: Int
    var sprites: SpritesResponse
    var types: [TypesResponse]
    var stats: [StatsResponse]
    var abilities: [AbilitiesResponse]
}

extension PokemonResponse {
    struct SpritesResponse: Codable {
        var front_default: URL
        var other: OtherResponse
        var versions: [String: [String: VersionSprites]]
        
        struct OtherResponse: Codable {
            var official_artwork: OfficialArtworkResponse
            
            struct OfficialArtworkResponse: Codable {
                var front_default: URL?
                var front_shiny: URL?
            }
            
            enum CodingKeys: String, CodingKey {
                case official_artwork = "official-artwork"
            }
        }
        
        struct VersionSprites: Codable {
            var frontDefault: URL?
            var frontShiny: URL?
            var backDefault: URL?
            var backShiny: URL?

            enum CodingKeys: String, CodingKey {
                case frontDefault = "front_default"
                case frontShiny = "front_shiny"
                case backDefault = "back_default"
                case backShiny = "back_shiny"
                
            }
        }
    }
    
    struct TypesResponse: Codable {
        var slot: Int
        var type: NameURLResponse
    }
    
    struct StatsResponse: Codable {
        var base_stat: Int
        var effort: Int
        var stat: NameURLResponse
    }
    
    struct AbilitiesResponse: Codable {
        var ability: NameURLResponse
        var is_hidden: Bool
        var slot: Int
    }
}



// 추상화란 ?
// 나는 게임 제작자다. 플레이어가 있고, 플레이어는 무기를 가질 수 있다.
// 플레이어 무기가 총, 칼, 도끼, 뿅뿅망치
// 플레이어는 "무기"를 가질 수 있다.
// 무기는 어떤 것이라도 될 수 있다.
// 무기 == 추상화되어있다.
// 추상화란? 같은 것은 묶고, 달라지는 부분을 분리하는 것을 의미해.
// 무기 -> 같은 것 = 공격한다.(func attack()) 달라지는 부분 공격(attack 함수 안의 내용)을 어떻게 하냐?
// 달라지는 부분만 따로 구현을 하는 것.

// 왜 추상화를 할까?
// 코드의 유연성 때문임. 왜 유연성이 증가하냐?
// 추상화가 되어있으면 언제든 변경이 가능. (예제로는 목업으로도 데이터를 가져오고, 실제로도 가져오고.)
// 의존성을 낮추는 것에 해당한다.
