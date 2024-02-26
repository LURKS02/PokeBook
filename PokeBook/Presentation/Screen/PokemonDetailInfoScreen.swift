//
//  PokeView.swift
//  PokeBook
//
//  Created by 디해 on 2023/03/20.
//

import SwiftUI
import Combine
import CoreData

struct PokemonDetailInfoScreen: View {
    let pokemonID: Int
    
    @StateObject private var viewModel = ViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var shinyToggle: Bool = false
    @State private var navigationOpacity: CGFloat = 0
    
    init(pokemonID: Int) {
        self.pokemonID = pokemonID
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                contentView
                .ignoresSafeArea()
                .task { viewModel.fetchPoke(id: pokemonID) }
                .overlay(alignment: .center) {
                    if !viewModel.isLoaded { PokeSpinner() }
                }
                
                animatedNavigationBar
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(content: toolbarContent)
        }
    }
    
    @ViewBuilder private var contentView: some View {
        ScrollView(showsIndicators: false) {
            if (viewModel.isLoaded) {
                self.content
                    .offsetHelper { previousOffset, currentOffset in
                        print(currentOffset)
                        navigationOpacity = -currentOffset > 100 ? 1.0 : 0.0
                    }
            }
        }
    }
    
    @ViewBuilder private var content: some View {
        VStack(spacing: 0) {
            OfficialImage(viewModel: viewModel,
                          shinyToggle: $shinyToggle)
            DetailInformation(viewModel: viewModel)
            SpecGraph(viewModel: viewModel)
            PokemonAbility(viewModel: viewModel)
            PokemonImages(shinyToggle: $shinyToggle, viewModel: viewModel)
            PokeDetailFlavorText(viewModel: viewModel)
        }
        .padding(.top, self.safeArea().top)
    }
}


// MARK: - Toolbar

private extension PokemonDetailInfoScreen {
    var animatedNavigationBar: some View {
        SafeBar()
            .shadow(color: .gray.opacity(0.3), radius: 2)
            .opacity(navigationOpacity)
            .animation(.easeInOut, value: navigationOpacity)
    }
    
    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            BackButton(presentationMode: presentationMode)
        }
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            LoveButton(viewModel: LoveButtonViewModel(pokemon: viewModel.pokemon.convertToCell()),
                       loveColor: .black)
            EllipsisButton()
        }
    }
}


// MARK: - Pokemon Official Image

private extension PokemonDetailInfoScreen {
    struct OfficialImage: View {
        let officialImageHeight: CGFloat = 350.0
        
        @ObservedObject var viewModel: ViewModel
        @Binding var shinyToggle: Bool
        
        var body: some View {
            
            ZStack(alignment: .bottomTrailing) {
                officialImage
                SparkleIcon(isSparkle: $shinyToggle)
            }
            .padding(20)
        }
        
        var officialImage: some View {
            AsyncImage(
                url: shinyToggle ? viewModel.pokemon.officialFrontShiny : viewModel.pokemon.officialFrontDefault,
            content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: officialImageHeight)
            },
            placeholder: {
                placeholderImage
                
            })
            .onTapGesture {
                shinyToggle.toggle()
            }
            .animation(.easeInOut(duration: 0.3))
        }
        
        var placeholderImage: some View {
            Color.white
                .frame(height: officialImageHeight)
        }
    }
}


// MARK: - Pokemon Name, Genera, Types

private extension PokemonDetailInfoScreen {
    struct DetailInformation: View {
        let iconSize: CGFloat = 70.0
        let iconPadding: CGFloat = 5.0
        let textPadding: CGFloat = 5.0
        
        @ObservedObject var viewModel: ViewModel
        
        var body: some View {
            VStack {
                SimpleLine()
                content
                    .padding(20)
                SimpleLine(height: 10,
                           opacity: 0.1)
            }
        }
        
        var content: some View {
            HStack(alignment: .top, spacing: 15) {
                dotImage
                pokemonInformations
                Spacer()
            }
        }
        
        var dotImage: some View {
            AsyncImage(url: viewModel.pokemon.dotFrontDefault)
            { image in
                image
                    .resizable()
                    .padding(iconPadding)
                    .frame(width: iconSize, height: iconSize)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(
                            Color.gray.opacity(0.3), lineWidth: 2))
            } placeholder: {
                Color.clear
                    .frame(width: iconSize, height: iconSize)
            }
            .animation(.easeInOut(duration: 0.3))
        }
        
        var pokemonInformations: some View {
            VStack(alignment: .leading, spacing: textPadding) {
                
                Text(viewModel.pokemon.name)
                    .font(.title2)
                    .fontWeight(.black)
                
                Text(viewModel.pokemon.genera)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                pokeSpec(height: viewModel.pokemon.height, weight: viewModel.pokemon.weight)
                
                Spacer()
                
                pokeDetailType(types: viewModel.pokemon.types)
            }
        }
        
        func pokeSpec(height: Int, weight: Int) -> some View {
            Text("키 ").font(.caption2) +
            Text("\(String(format: "%.1f", Double(height)/10))m")
                .font(.caption2)
                .fontWeight(.bold) +
            Text("  몸무게 ").font(.caption2) +
            Text("\(String(format: "%.1f", Double(weight)/10))kg")
                .font(.caption2)
                .fontWeight(.bold)
        }
        
        func pokeDetailType(types: [String]) -> some View {
            HStack {
                ForEach(types, id: \.self) { type in
                    PokeType(type: type, buttonSize: .big)
                }
            }
        }
    }
}


// MARK: - Pokemon Spec

private extension PokemonDetailInfoScreen {
    struct SpecGraph: View {
        @ObservedObject var viewModel: ViewModel
        
        var body: some View {
            content
                .padding(20)
        }
        
        var content: some View {
            VStack(spacing: 10) {
                ForEach(viewModel.pokemon.stats, id: \.self) { stat in
                    StatBar(stat: Stat(rawValue: stat.name),
                            value: stat.baseStat)
                }
            }
        }
    }
}


// MARK: - Pokemon Ability

private extension PokemonDetailInfoScreen {
    struct PokemonAbility: View {
        @ObservedObject var viewModel: ViewModel
        
        var body: some View {
            VStack {
                SimpleLine(height: 10, opacity: 0.1)
                content
                    .padding(.top, 15)
                    .padding(.bottom, 20)
                    .padding(.horizontal)
            }
        }
        
        var content: some View {
            VStack(alignment: .leading) {
                SubTitle(title: "특성")
                
                ForEach (viewModel.pokemon.abilities, id: \.self) { ability in
                    AbilityBar(name: ability.name, flavorText: ability.flavorText, isHidden: ability.is_hidden)
                }
            }
        }
    }
}


// MARK: - Pokemon Images by Version

private extension PokemonDetailInfoScreen {
    struct PokemonImages: View {
        @Binding var shinyToggle: Bool;
        let pokemonImageSize: CGFloat = 100;
        
        @ObservedObject var viewModel: ViewModel
        
        var body: some View {
            VStack {
                SimpleLine(height: 10, opacity: 0.1)
                content
                    .padding(20)
            }
        }
        
        var content: some View {
            VStack(alignment: .leading, spacing: 20) {
                
                SubTitle(title: "버전별 모습")
                
                ForEach(viewModel.pokemon.versionPokemonImages, id: \.self) { index in
                    PokemonImageView(pokemonImage: index, pokemonImageSize: pokemonImageSize, shinyToggle: $shinyToggle)
                }
            }
        }
    }
}


// MARK: - Pokemon Flavor Texts

private extension PokemonDetailInfoScreen {
    struct PokeDetailFlavorText: View {
        @ObservedObject var viewModel: ViewModel
        
        var body: some View {
            VStack {
                SimpleLine(height: 10, opacity: 0.1)
                content
                    .padding(20)
            }
        }
        
        var content: some View {
            VStack(alignment: .leading, spacing: 20) {
                SubTitle(title: "도감 설명")
                
                ForEach(viewModel.pokemon.flavorTextEntries, id: \.self) { entry in
                    FlavorTextBar(version: Version(rawValue: entry.version), flavorText: entry.flavorText)
                }
            }
        }
    }
}


// MARK: - View Model

extension PokemonDetailInfoScreen {
    // view's logic
    // logic -> data fetching and show (at view).
    // logic -> view appearing.
    
    class ViewModel: ObservableObject {
        @Published var pokemon: Pokemon
        @Published var isLoaded: Bool
        @Published var isLiked: Bool
        
        init() {
            pokemon = Pokemon(
                id: 0,
                name: "",
                genera: "",
                height: 0,
                weight: 0,
                dotFrontDefault: nil,
                officialFrontDefault: nil,
                officialFrontShiny: nil,
                types: [],
                versionPokemonImages: [],
                stats: [],
                flavorTextEntries: [],
                abilities: []
            )
            isLoaded = false
            isLiked = false
        }
        
        let repo: PokeRepository = DIContainer().getPokeRepository(isReal: true)
        var cancelBag = Set<AnyCancellable>()
        
        func fetchPoke(id: Int) {
            repo.fetchPokemon(id: id)
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: {
                    self.pokemon = $0
                    self.isLoaded = true
                })
                .store(in: &cancelBag)
        }
    }
}


// MARK: - Preview

struct PokeView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailInfoScreen(pokemonID: 1)
    }
}

// View Must Be Dumb
// sprites(x), image: URL

