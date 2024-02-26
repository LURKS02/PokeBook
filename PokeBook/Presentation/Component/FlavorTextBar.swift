//
//  FlavorTextBar.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/26.
//

import SwiftUI

enum Version {
    case x
    case y
    case omegaRuby
    case alphaSapphire
    case sun
    case moon
    case ultraSun
    case ultraMoon
    case letsGoPikachu
    case letsGoEevee
    case sword
    case shield
    case none
    
    init(rawValue: String) {
        switch rawValue {
        case "x":
            self = .x
        case "y":
            self = .y
        case "omega-ruby":
            self = .omegaRuby
        case "alpha-sapphire":
            self = .alphaSapphire
        case "sun":
            self = .sun
        case "moon":
            self = .moon
        case "ultra-sun":
            self = .ultraSun
        case "ultra-moon":
            self = .ultraMoon
        case "lets-go-pikachu":
            self = .letsGoPikachu
        case "lets-go-eevee":
            self = .letsGoEevee
        case "sword":
            self = .sword
        case "shield":
            self = .shield
        default:
            self = .none
        }
    }
    
    var name: String {
        switch self {
        case .x: return "X"
        case .y: return "Y"
        case .omegaRuby: return "오메가 루비"
        case .alphaSapphire: return "알파 사파이어"
        case .sun: return "썬"
        case .moon: return "문"
        case .ultraSun: return "울트라 썬"
        case .ultraMoon: return "울트라 문"
        case .letsGoPikachu: return "레츠고! 피카츄"
        case .letsGoEevee: return "레츠고! 이브이"
        case .sword: return "소드"
        case .shield: return "실드"
        case .none: return "default"
        }
    }
    
    var color: String {
        switch self {
        case .x: return "3271c9"
        case .y: return "c9325a"
        case .omegaRuby: return "c93232"
        case .alphaSapphire: return "32a6c9"
        case .sun: return "FDAE54"
        case .moon: return "54C5FD"
        case .ultraSun: return "ff8138"
        case .ultraMoon: return "38d4ff"
        case .letsGoPikachu: return "FFD45D"
        case .letsGoEevee: return "976C46"
        case .sword: return "26C6FF"
        case .shield: return "FC4E7D"
        case .none: return "000000"
        }
    }
}

struct FlavorTextBar: View {
    let version: Version
    let flavorText: String
    
    var body: some View {
        content
            .frame(maxWidth: .infinity,
                   alignment: .leading)
            .padding(15)
            .background {
                Color.white
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.15),
                            radius: 3)
            }
    }
    
    var content: some View {
        VStack(alignment: .leading) {
            Text(version.name)
                .versionTag(versionColor: version.color)
            Text(flavorText)
                .font(.subheadline)
        }
    }
}

struct FlavorTextBar_Previews: PreviewProvider {
    static var previews: some View {
        FlavorTextBar(version: .sword, flavorText: "flavor text")
    }
}
