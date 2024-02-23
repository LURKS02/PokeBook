//
//  LoveButton.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/20.
//

import SwiftUI

struct LoveButton: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
    @ObservedObject var viewModel: LoveButtonViewModel
    
    let loveColor: Color
    
    var body: some View {
        Button(action: {
            withAnimation(Animation
                .easeInOut(duration: 0.2)
                .repeatCount(1, autoreverses: true)) {
                    viewModel.isLiked.toggle()
                }
            
            if viewModel.isLiked {
                viewModel.addLiked()
            }
            else {
                viewModel.deleteLiked()
            }
        }) {
            Image(systemName: viewModel.isLiked ? "heart.fill" : "heart")
                .resizable()
                .shadow(radius: !viewModel.isLiked && loveColor == .white ? 1 : 0)
                .frame(width: viewModel.isLiked ? 22 : 20, height: viewModel.isLiked ? 22 : 20)
                .foregroundColor(viewModel.isLiked ? .pink : loveColor)
        }
        .frame(width: 22, height: 22)
        .onAppear {
            viewModel.checkLiked()
        }
    }
}

final class LoveButtonViewModel: ObservableObject {
    @Published var pokemon: PokemonCell
    @Published var isLiked: Bool
    
    init(pokemon: PokemonCell) {
        self.pokemon = pokemon
        isLiked = false
        checkLiked()
    }
    
    func addLiked() {
        PersistenceController.shared.addLiked(byPokemon: pokemon)
    }
    
    func deleteLiked() {
        PersistenceController.shared.deleteLiked(byID: pokemon.id)
    }
    
    func checkLiked() {
        let existLiked = PersistenceController.shared.hasLiked(byID: pokemon.id)
        if (existLiked != nil) {
            isLiked = true
        } else {
            isLiked = false
        }
    }
}

struct LoveButton_Previews: PreviewProvider {
    @State static var isLiked = false
    
    static var previews: some View {
        LoveButton(viewModel: LoveButtonViewModel(pokemon: PokemonCell(id: 1, name: "dd", genera: "dd", types: [])),
                   loveColor: .white)
    }
}
