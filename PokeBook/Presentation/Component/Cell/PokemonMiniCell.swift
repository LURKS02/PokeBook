//
//  PokeMiniCell.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/23.
//

import SwiftUI
import CoreData

struct PokemonMiniCell: View {

    let pokemon: PokemonCell
    let action: () -> ()
    
    var body: some View {
        Button(action: action) {
            content
        }
            .padding(.vertical, 13)
            .padding(.horizontal, 10)
            .background(RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .shadow(color: Color.gray.opacity(0.5), radius: 2))
    }
    
    private var content: some View {
        VStack(spacing: 10) {
            AsyncImage(url: pokemon.dotFrontDefault) { image in
                image
                    .resizable()
                    //.scaleEffect(1.2)
                    .scaledToFit()
            } placeholder: {
                Color.white
            }
            
            VStack(spacing: 7) {
                Text(pokemon.name)
                    .font(.subheadline)
                    .fontWeight(.black)
                    .foregroundColor(.black)
                
                HStack(spacing: 5) {
                    ForEach(pokemon.types, id: \.self) { type in
                        PokeType(type: type, buttonSize: .small)
                    }
                }
            }
        }
    }
}

struct PokeMiniCell_Previews: PreviewProvider {
    
    static var previews: some View {
        PokemonMiniCell(pokemon: Pokemon.mockedData.convertToCell(),
                        action: {})
    }
}
