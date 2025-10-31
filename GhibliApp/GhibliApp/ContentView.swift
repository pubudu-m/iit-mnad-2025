//
//  ContentView.swift
//  GhibliApp
//
//  Created by Pubudu Mihiranga on 2025-10-31.
//

import SwiftUI

struct ContentView: View {
    @State var filmsViewModel = FilmsViewModel()
    @State private var favoritesViewModel = FavoritesViewModel()
    
    var body: some View {
        TabView {
            Tab("Movies", systemImage: "movieclapper") {
                FilmsScreen(filmsViewModel: filmsViewModel, favoritesViewModel: favoritesViewModel)
            }
            
            Tab("Favorites", systemImage: "heart") {
                FavoritesScreen(filmsViewModel: filmsViewModel, favoritesViewModel: favoritesViewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
