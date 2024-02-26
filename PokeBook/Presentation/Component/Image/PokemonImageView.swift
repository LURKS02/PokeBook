//
//  PokemonImage.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/02.
//

import SwiftUI

struct PokemonImageView: View {
    let pokemonImage: Pokemon.PokemonImage
    let pokemonImageSize: CGFloat
    
    @Binding var shinyToggle: Bool
    
    var body: some View {
        
        VStack () {
            ZStack(alignment: .bottomTrailing) {
                ZStack() {
                    Color.white
                        .frame(height: 100)
                    
                    VersionPokemonImage(frontImage: shinyToggle && isShinyExist(pokemonImage: pokemonImage) ? pokemonImage.frontShiny : pokemonImage.frontDefault,
                                        backImage: shinyToggle && isShinyExist(pokemonImage: pokemonImage) ? pokemonImage.backShiny : pokemonImage.backDefault, pokemonImageSize: pokemonImageSize)
                }
            }
            
            SimpleLine()
            
            VersionTitle(version: pokemonImage.version)
        }
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(hexString: "ededed"), lineWidth: 2)
            
        }
        .onTapGesture {
            if (isShinyExist(pokemonImage: pokemonImage)) {
                withAnimation {
                    self.shinyToggle.toggle()
                }
            }
        }
    }
    
}

struct VersionPokemonImage: View {
    let frontImage: URL?
    let backImage: URL?
    let pokemonImageSize: CGFloat
    
    var body: some View {
        HStack(alignment: .center) {
            
            if (frontImage != nil) {
                AsyncImage(url: frontImage) {
                    image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: pokemonImageSize)
                } placeholder: {
                    Color.white
                }
                .animation(.easeInOut(duration: 0.3))
            }
            
            if (backImage != nil) {
                AsyncImage(url: backImage) {
                    image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: pokemonImageSize)
                } placeholder: {
                    Color.white
                }
                .animation(.easeInOut(duration: 0.3))
            }
            
        }
    }
}

struct VersionTitle: View {
    let version: String
    
    var body: some View {
        switch version {
        case "red-blue":
            HStack {
                Text("레드").versionTag(versionColor: "ff1414")
                Text("블루").versionTag(versionColor: "1462ff")
            }
        case "yellow":
            Text("옐로우").versionTag(versionColor: "ffe414")
        case "crystal":
            Text("크리스탈").versionTag(versionColor: "abf5f4")
        case "gold":
            Text("골드").versionTag(versionColor: "d4b115")
        case "silver":
            Text("실버").versionTag(versionColor: "bfbfbf")
        case "emerald":
            Text("에메랄드").versionTag(versionColor: "14ffcc")
        case "firered-leafgreen":
            HStack {
                Text("파이어레드").versionTag(versionColor: "fa6019")
                Text("리프그린").versionTag(versionColor: "5e9937")
            }
        case "ruby-sapphire":
            HStack {
                Text("루비").versionTag(versionColor: "cf3247")
                Text("사파이어").versionTag(versionColor: "3f43bf")
            }
        case "diamond-pearl":
            HStack {
                Text("다이아몬드").versionTag(versionColor: "dae6f5")
                Text("펄").versionTag(versionColor: "f5dade")
            }
        case "heartgold-soulsilver":
            HStack {
                Text("하트골드").versionTag(versionColor: "ebbfab")
                Text("소울실버").versionTag(versionColor: "d5d1e6")
            }
        case "platinum":
            Text("플라티나").versionTag(versionColor: "706966")
        case "black-white":
            HStack {
                Text("블랙").versionTag(versionColor: "212121")
                Text("화이트").versionTag(versionColor: "f5f5f5")
            }
        case "omegaruby-alphasapphire":
            HStack {
                Text("오메가루비").versionTag(versionColor: "c93232")
                Text("알파사파이어").versionTag(versionColor: "32a6c9")
            }
        case "x-y":
            HStack {
                Text("X").versionTag(versionColor: "3271c9")
                Text("Y").versionTag(versionColor: "c9325a")
            }
        case "ultra-sun-ultra-moon":
            HStack {
                Text("울트라썬").versionTag(versionColor: "ff8138")
                Text("울트라문").versionTag(versionColor: "38d4ff")
            }
        default:
            Text("로딩 중")
                .versionTag(versionColor: "000000")
        }
    }
}
