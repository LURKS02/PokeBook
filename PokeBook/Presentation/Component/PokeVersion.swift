//
//  PokeVersion.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/17.
//

import SwiftUI

struct PokeVersion: View {
    let version: String
    
    var body: some View {
        Text(versionName)
                .versionTag(versionColor: versionColor)
    }
    
    var versionName: String {
        switch version {
        case "x": return "X"
        case "y": return "Y"
        case "omega-ruby": return "오메가 루비"
        case "alpha-sapphire": return "알파 사파이어"
        case "sun": return "썬"
        case "moon": return "문"
        case "ultra-sun": return "울트라 썬"
        case "ultra-moon": return "울트라 문"
        case "lets-go-pikachu": return "레츠고! 피카츄"
        case "lets-go-eevee": return "레츠고! 이브이"
        case "sword": return "소드"
        case "shield": return "실드"
        default: return version
        }
    }
    
    var versionColor: String {
        switch version {
        case "x": return "3271c9"
        case "y": return "c9325a"
        case "omega-ruby": return "c93232"
        case "alpha-sapphire": return "32a6c9"
        case "sun": return "FDAE54"
        case "moon": return "54C5FD"
        case "ultra-sun": return "ff8138"
        case "ultra-moon": return "38d4ff"
        case "lets-go-pikachu": return "FFD45D"
        case "lets-go-eevee": return "976C46"
        case "sword": return "26C6FF"
        case "shield": return "FC4E7D"
        default: return "000000"
        }
    }
}

struct PokeVersion_Previews: PreviewProvider {
    static var previews: some View {
        PokeVersion(version: "x")
    }
}
