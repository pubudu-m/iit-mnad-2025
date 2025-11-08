//
//  ContentView.swift
//  GhibliAppPT
//
//  Created by Pubudu Mihiranga on 2025-11-01.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var filmsViewModel = FilmsViewModel()
    @State private var favouritesViewModel = FavouritesViewModel()
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        TabView {
            Tab("Movies", systemImage: "movieclapper") {
                FilmsScreen(filmsViewModel: filmsViewModel,
                            favoritesViewModel: favouritesViewModel)
            }
            
            Tab("Favorites", systemImage: "heart") {
                FavouritesScreen(filmsViewModel: filmsViewModel,
                                 favoritesViewModel: favouritesViewModel)
            }
            
            Tab("Settings", systemImage: "gear") {
                SettingsView()
            }
        }
        .task {
            favouritesViewModel.configure(modelContext: modelContext)
            await filmsViewModel.fetch()
        }
        .setAppearanceTheme()
    }
}

#Preview {
    ContentView()
}
