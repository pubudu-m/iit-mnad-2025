//
//  DefaultFavoriteStorage.swift
//  GhibliApp
//
//  Created by Pubudu Mihiranga on 2025-10-31.
//

import Foundation
import SwiftData

struct DefaultFavoriteStorage: FavoriteStorage {
    let modelContext: ModelContext
    
    func load() -> Set<String> {
        let descriptor = FetchDescriptor<Favorite>()
        
        do {
            let favorites = try modelContext.fetch(descriptor)
            return Set(favorites.map { $0.filmID })
        } catch {
            print("Failed to load favorites: \(error)")
            return []
        }
    }
    
    // Break it down to 2 funcs
    // markAsFav & markasUnfav
    func save(favoriteIDs: Set<String>) {
        do {
            // Fetch existing favorites
            let descriptor = FetchDescriptor<Favorite>()
            let existing = try modelContext.fetch(descriptor)

            // Determine which ones to add/remove
            let existingIDs = Set(existing.map { $0.filmID })

            // Remove favorites that no longer exist
            for favorite in existing where !favoriteIDs.contains(favorite.filmID) {
                modelContext.delete(favorite)
            }

            // Add new favorites
            let newIDs = favoriteIDs.subtracting(existingIDs)
            for id in newIDs {
                modelContext.insert(Favorite(filmID: id))
            }

            try modelContext.save()
        } catch {
            print("Failed to save favorites: \(error)")
        }
    }
}
