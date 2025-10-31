//
//  FilmListView.swift
//  GhibliApp
//
//  Created by Pubudu Mihiranga on 2025-10-31.
//

import SwiftUI

struct FilmListView: View {
    var films: [Film]
    let favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        
        List(films) { film in
            NavigationLink(value: film) {
               FilmRow(film: film,
                       favoritesViewModel: favoritesViewModel)
            }
            
        }
        .navigationDestination(for: Film.self) { film in
            FilmDetailScreen(film: film,
                             favoritesViewModel: favoritesViewModel)
        }
    }
}

private struct FilmRow: View {
    let film: Film
    let favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            FilmImageView(urlPath: film.image)
                .frame(width: 100, height: 150)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(film.title)
                    .bold()
                
                Text("Directed by \(film.director)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Released: \(film.releaseYear)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                FavoriteButton(filmID: film.id,
                               favoritesViewModel: favoritesViewModel)
                .buttonStyle(.plain)
                .controlSize(.large)
            }
            .padding(.top)
        }
    }
}
