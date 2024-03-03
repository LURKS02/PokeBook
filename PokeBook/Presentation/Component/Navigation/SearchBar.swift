//
//  SearchBar.swift
//  PokeBook
//
//  Created by 디해 on 2023/07/10.
//

import UIKit
import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    
    var body: some View {
        SearchBar(text: $text)
            .padding(.horizontal)
            .background {
                Color.get(.background(.screen))
                    .shadow(color: .gray.opacity(0.3), radius: 2)
            }
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) ->
    UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "어떤 포켓몬을 검색할까요?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        searchBar.searchTextField.font = .systemFont(ofSize: 15)
        searchBar.backgroundColor = UIColor(Color.get(.background(.screen)))
        
        return searchBar
    }
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
}

extension SearchBar {
    final class Coordinator: NSObject, UISearchBarDelegate {
        let text: Binding<String>
        
        init(text:Binding<String>) {
            self.text = text
        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text.wrappedValue = searchText
        }
    }
}


