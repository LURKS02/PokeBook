//
//  LikedPokeListScreen.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/22.
//

import SwiftUI
import CoreData

struct LikedPokeListScreen: View {
    @StateObject private var viewModel = ViewModel()
    @Binding var selection: TabIndex
    
    var body: some View {
        self.content
            .background(Color.get(.background(.screen)))
            .onChange(of: selection) { newValue in
                if newValue == .liked {
                    viewModel.fetchLikeds()
                }
            }
    }
    
    @ViewBuilder private var content: some View {
        if (viewModel.pokemons.isEmpty) {
            NoLikedView()
        }
        else {
            LikedView(likedListViewModel: viewModel)
        }
    }
}

private extension LikedPokeListScreen {
    struct NoLikedView: View {
        var body: some View {
            VStack() {
                Text("아직 좋아요한 포켓몬이 없어요.")
                    .foregroundColor(.get(.text(.primary)))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    struct LikedView: View {
        @ObservedObject var likedListViewModel: ViewModel
        
        @State private var selectedPoke: PokemonCell?
        
        private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
        
        var body: some View {
            ScrollView(showsIndicators: false) {
                pokeMiniGridView(columns: columns)
            }
            .onChange(of: selectedPoke) { newValue in
                if newValue == nil {
                    likedListViewModel.fetchLikeds()
                }
            }
            .onAppear {
                likedListViewModel.fetchLikeds()
            }
        }
        
        func pokeMiniGridView(columns: [GridItem]) -> some View {
            LazyVGrid(columns: columns) {
                ForEach(likedListViewModel.pokemons) { pokemon in
                    NavigationLink(destination: PokemonDetailInfoScreen(pokemonID: pokemon.id)) {
                        PokemonMiniCell(pokemon: pokemon)
                    }
                }
            }
            .padding()
        }
    }
}

extension LikedPokeListScreen {
    final class ViewModel: ObservableObject {
        @Published var pokemons: [PokemonCell]
        
        private var context: NSManagedObjectContext
        
        init() {
            pokemons = []
            context = PersistenceController.shared.container.viewContext
        }
        
        func fetchLikeds() {
            let fetchRequest: NSFetchRequest<LikedPokemon> = LikedPokemon.fetchRequest()
            do {
                pokemons = try context.fetch(fetchRequest)
                    .map { $0.convertToPokemonCell() }
                
            } catch {
                print("Failed to fetch items.")
            }
        }
    }
}


struct LikedPokeListScreen_Previews: PreviewProvider {
    static var previews: some View {
        LikedPokeListScreen(selection: .constant(.liked))
    }
}
