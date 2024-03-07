//  PokeList.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/03.
//

import Combine
import SwiftUI
import Lottie
import CoreData

struct PokemonListScreen: View {
    @StateObject private var viewModel = ViewModel()
    @State var pokemonSearch = PokemonSearch()
    @State var headerHeight: CGFloat = 0
    @State var safeAreaHeight: CGFloat = 0
    
    var body: some View {
        self.content
            .background(Color.get(.background(.screen)))
            .onAppear {
            self.safeAreaHeight = safeArea().top
            }
    }
    
    @ViewBuilder private var content: some View {
        ZStack(alignment: .top) {
            switch viewModel.state {
            case .loading:
                LoadingView
            case .searching:
                SearchingView
            case .loaded:
                LoadedContent(viewModel: viewModel,
                              headerHeight: $headerHeight,
                              safeAreaHeight: $safeAreaHeight)
            }
            HeaderView
        }
    }
    
    @ViewBuilder private var HeaderView: some View {
        SearchBarView(text: $viewModel.searchText)
            .heightHelper { height in
                headerHeight = height
                print(height)
            }
            .offset(y: viewModel.direct == .up ? 0 : -headerHeight)
            .animation(.easeInOut, value: viewModel.direct)
    }
}


// MARK: - Displaying Content

private extension PokemonListScreen {
    struct LoadedContent: View {
        @ObservedObject var viewModel: ViewModel
        @Binding var headerHeight: CGFloat
        @Binding var safeAreaHeight: CGFloat
        
        @State var selectedPoke: PokemonCell?
        
        private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
        
        var body: some View {
            if (viewModel.pokemons.isEmpty) {
                NoResultView
            }
            else {
                LoadedView
            }
        }
        
        var LoadedView: some View {
            ScrollView(.vertical, showsIndicators: false) {
                pokeGridView(columns: columns)
                    .offsetHelper { previousOffset, currentOffset in
                        viewModel.direct = currentOffset < previousOffset && currentOffset < 0 ? .down : .up
                    }
            }
            .padding(.horizontal)
//            .fullScreenCover(item: $selectedPoke) { pokemon in
//                PokemonDetailInfoScreen(pokemonID: pokemon.id)
//            }
        }
        
        
        var NoResultView: some View {
            VStack {
                LottieView(jsonName: "sad")
                    .frame(maxHeight: 200)
                    .cornerRadius(20)
                    .padding()
                Text("검색 결과가 없습니다.")
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
        func pokeGridView(columns: [GridItem]) -> some View {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.pokemons) { pokemon in
                    NavigationLink(destination: PokemonDetailInfoScreen(pokemonID: pokemon.id)) {
                        PokemonBigCell(viewModel: LoveButtonViewModel(pokemon: pokemon))
                    }
                    .onAppear {
                        if (viewModel.searchText == "") {
                            viewModel.loadNextPage(value: 50, pokemon: pokemon)
                        }
                    }
                }
            }
            .padding(.top, headerHeight + 15)
        }
    }
}


// MARK: - Loading Content

private extension PokemonListScreen {
    var LoadingView: some View {
        VStack {
            PokeSpinner()
            Text("불러오는 중...")
                .foregroundColor(.get(.text(.primary)))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var SearchingView: some View {
        VStack {
            PokeSpinner()
            Text("검색 중...")
                .foregroundColor(.get(.text(.primary)))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


// MARK: - ViewModel

extension PokemonListScreen {
    final class ViewModel: ObservableObject {
        enum State {
            case loading
            case searching
            case loaded
        }
        
        @Published var searchText: String
        @Published var pokemons: [PokemonCell]
        @Published var state: State
        @Published var direct: Direct
        
        var searchCancellable: AnyCancellable?
        var nextURL: URL?
        var previousScrollOffset: CGFloat = 0
        var persistenceController: PersistenceController = .shared
        
        init() {
            searchText = ""
            pokemons = []
            state = .loading
            direct = .none
            
            setupSearchText()
        }
        
        let repo: PokeRepository = DIContainer().getPokeRepository(isReal: true)
        var cancelBag = Set<AnyCancellable>()
        
        func fetchPokes() {
            searchCancellable?.cancel()
            guard let url = nextURL else { return }
            
            searchCancellable = repo.fetchPokemonPagination(nextURL: url)
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { [weak self] in
                    self?.pokemons += $0.pokeList
                    self?.nextURL = $0.next ?? nil
                    self?.state = .loaded
                })
            searchCancellable?.store(in: &cancelBag)
        }
        
        func setupSearchText() {
            $searchText
                .debounce(for: 0.5, scheduler: DispatchQueue.main)
                .sink { [weak self] in
                    self?.performSearch(query : $0)
                }
                .store(in: &cancelBag)
        }
        
        func performSearch(query: String) {
            searchCancellable?.cancel()
            
            if query.isEmpty {
                state = .loading
                pokemons = []
                nextURL = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=50")!
                fetchPokes()
            } else {
                state = .searching
                
                searchCancellable = repo.searchPokemon(query: query)
                    .receive(on: DispatchQueue.main)
                    .sink(receiveValue: { [weak self] in
                        self?.pokemons = $0.pokeList
                        self?.state = .loaded
                    })
            }
            searchCancellable?.store(in: &cancelBag)
        }
        
        func loadNextPage(value: Int, pokemon: PokemonCell) {
            guard let index = pokemons.firstIndex(where: { $0.id == pokemon.id} ) else { return }
            if index % value == value - 10 {
                DispatchQueue.main.async { self.fetchPokes() }
            }
        }
    }
}

// MARK: - Search State

extension PokemonListScreen {
    struct PokemonSearch {
        var searchText: String = ""
    }
}

// MARK: - Preview

struct PokeList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListScreen()
    }
}
