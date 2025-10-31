//
//  FavoritesViewModel.swift
//  GhibliApp
//
//  Created by Pubudu Mihiranga on 2025-10-31.
//

import Foundation
import Observation
import SwiftData

@Observable
class FavoritesViewModel {
    private(set) var favoriteIDs: Set<String> = []
    private var service: FavoriteStorage?
    
    init(service: FavoriteStorage? = nil) {
        self.service = service
    }
    
    func configure(modelContext: ModelContext) {
        guard service == nil else { return }
        service = DefaultFavoriteStorage(modelContext: modelContext)
        load()
    }
    
    func load() {
        guard let service = service else {
            favoriteIDs = []
            return
        }
        favoriteIDs = service.load()
    }
    
    private func save() {
        service?.save(favoriteIDs: favoriteIDs)
    }
    
    func toggleFavorite(filmID: String) {
        if favoriteIDs.contains(filmID) {
            favoriteIDs.remove(filmID)
        } else {
            favoriteIDs.insert(filmID)
        }
        
        save()
    }
    
    
    func isFavorite(filmID: String) -> Bool {
        favoriteIDs.contains(filmID)
    }
}
