//
//  SearchScreen.swift
//  AnimePrepApp
//
//  Created by Pubudu Mihiranga on 2025-10-29.
//

import SwiftUI

struct SearchScreen: View {
    @State private var text: String = ""
    @State private var searchViewModel: SearchFilmsViewModel
    
    let favoritesViewModel: FavoritesViewModel
    
    init(favoritesViewModel: FavoritesViewModel,
         service: GhibliService = DefaultGhibliService()) {
        self.favoritesViewModel = favoritesViewModel
        self.searchViewModel = SearchFilmsViewModel(service: service)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                switch searchViewModel.state {
                    case .idle:
                        Text("Your search results will be shown here.")
                            .foregroundStyle(.secondary)
                    case .loading:
                        ProgressView()
                    case .error(let error):
                        Text(error)
                    case .loaded(let films):
                        FilmListView(films: films,
                                     favoritesViewModel: favoritesViewModel)
                }
            }
            .navigationTitle("Search Ghibli Movies")
            .searchable(text: $text)
            .task(id: text) {
                await searchViewModel.fetch(for: text)
            }
        }
    }
}
