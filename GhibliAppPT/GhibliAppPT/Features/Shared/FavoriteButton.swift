//
//  FavoriteButton.swift
//  GhibliAppPT
//
//  Created by Pubudu Mihiranga on 2025-11-01.
//

import SwiftUI

struct FavoriteButton: View {
    let filmID: String
    let favoritesViewModel: FavouritesViewModel
    
    var isFavorite: Bool {
        favoritesViewModel.isFavorite(filmID: filmID)
    }
    
    var body: some View {
        Button {
            favoritesViewModel.toggleFavorite(filmID: filmID)
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundStyle(isFavorite ? Color.pink : Color.gray)
        }
    }
}
