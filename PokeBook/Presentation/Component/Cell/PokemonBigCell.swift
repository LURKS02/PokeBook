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
//    let action: () -> Void
    
    var body: some View {
        
//        Button(action: action) {
//            content
//        }
        content
        .padding()
        .background(RoundedRectangle(cornerRadius: 20)
                .fill(Color.get(.background(.cell))))
        .overlay(RoundedRectangle(cornerRadius: 20)
            .stroke(Color.get(.background(.stroke)), lineWidth: 1.5))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder private var content: some View {
        
        VStack {
            ZStack(alignment: .topTrailing) {
                
                ImageSourceView(url: viewModel.pokemon.officialFrontDefault!)
                
                LoveButton(viewModel: viewModel,
                           loveColor: Color.get(.background(.screen)))
            }
            
            Text(viewModel.pokemon.name)
                .font(.title2)
                .fontWeight(.black)
                .foregroundColor(Color.get(.text(.primary)))
            
            Text(viewModel.pokemon.genera)
                .font(.subheadline)
                .foregroundColor(Color.get(.text(.secondary)))
            
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
        PokemonBigCell(viewModel: LoveButtonViewModel(pokemon: Pokemon.mockedData.convertToCell()))
    }
}
