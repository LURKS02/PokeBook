//
//  PokeListCell.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/09.
//

import SwiftUI
import Combine

struct PokemonBigCell: View {
    @StateObject var viewModel: LoveButtonViewModel
//    let name: String
//    let type: String
//    let isLiked: Bool
    let action: () -> Void
    
    var body: some View {
        
        Button(action: action) {
            content
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 20)
            .stroke(Color(hexString: "e0e0e0"), lineWidth: 1))
        .frame(maxWidth: .infinity, maxHeight: 300)
    }
    
    @ViewBuilder private var content: some View {
        
        VStack {
            ZStack(alignment: .topTrailing) {
                
                ImageSourceView(url: viewModel.pokemon.officialFrontDefault!)
                
                LoveButton(viewModel: viewModel,
                           loveColor: .white)
            }
            
            Text(viewModel.pokemon.name)
                .font(.title2)
                .fontWeight(.black)
                .foregroundColor(.black)
            
            Text(viewModel.pokemon.genera)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            HStack {
                ForEach(viewModel.pokemon.types, id: \.self) { type in
                    PokeType(type: type, buttonSize: .big)
                }
            }
        }
    }
}

struct PokeListCell_Previews: PreviewProvider {
    
    static var previews: some View {
        PokemonBigCell(viewModel: LoveButtonViewModel(pokemon: Pokemon.mockedData.convertToCell()),
                       action: {})
    }
}
