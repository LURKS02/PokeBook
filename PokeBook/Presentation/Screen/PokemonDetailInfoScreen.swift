

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

