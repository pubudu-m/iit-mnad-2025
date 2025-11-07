//
//  FilmsScreen.swift
//  GhibliAppPT
//
//  Created by Pubudu Mihiranga on 2025-11-01.
//

import SwiftUI

struct FilmsScreen: View {
    let filmsViewModel: FilmsViewModel
    let favoritesViewModel: FavouritesViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                switch filmsViewModel.state {
                case .idle:
                    Text("No Films yet")
                case .loading:
                    ProgressView {
                        Text("Loading...")
                    }
                case .loaded(let films):
                    FilmListView(films: films, favoritesViewModel: favoritesViewModel)
                case .error(let error):
                    Text(error)
                        .foregroundStyle(.red)
                }
            }
        }
    }
}
