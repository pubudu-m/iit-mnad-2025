//
//  FavouritesViewModel.swift
//  GhibliAppPT
//
//  Created by Pubudu Mihiranga on 2025-11-01.
//

import Foundation
import Observation
import SwiftData

@Observable
class FavouritesViewModel {
    private(set) var favoriteIDs: Set<String> = []
    private var service: DefaultStorageService?
    
    init(service: DefaultStorageService? = nil) {
        self.service = service
    }
    
    func configure(modelContext: ModelContext) {
        guard service == nil else { return }
        service = DefaultStorageService(modelContext: modelContext)
        load()
    }
    
    func load() {
        guard let service = service else {
            favoriteIDs = []
            return
        }
        favoriteIDs = service.load()
    }
    
    func toggleFavorite(filmID: String) {
        if favoriteIDs.contains(filmID) {
            favoriteIDs.remove(filmID)
        } else {
            favoriteIDs.insert(filmID)
        }
        
        save()
    }
    
    private func save() {
        service?.save(favoriteIDs: favoriteIDs)
    }
    
    func isFavorite(filmID: String) -> Bool {
        favoriteIDs.contains(filmID)
    }
}

extension FavouritesViewModel {
    func customfun() {
        // new imple
    }
}
