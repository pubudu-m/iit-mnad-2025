//
//  FavoriteButton.swift
//  GhibliApp
//
//  Created by Pubudu Mihiranga on 2025-10-31.
//

import SwiftUI

struct FavoriteButton: View {
    
    let filmID: String
    let favoritesViewModel: FavoritesViewModel
    
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
