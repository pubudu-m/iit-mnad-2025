//
//  FavouritesScreen.swift
//  GhibliAppPT
//
//  Created by Pubudu Mihiranga on 2025-11-01.
//

import SwiftUI

struct FavouritesScreen: View {
    let filmsViewModel: FilmsViewModel
    let favoritesViewModel: FavouritesViewModel
    
    var films: [Film] {
        let favorites = favoritesViewModel.favoriteIDs
        
        switch filmsViewModel.state {
        case .loaded(let films):
            return films.filter { favorites.contains($0.id) }
        default: return []
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if films.isEmpty {
                    Text("No fav items yet")
                } else {
                    FilmListView(films: films, favoritesViewModel: favoritesViewModel)
                }
            }
        }
    }
}
