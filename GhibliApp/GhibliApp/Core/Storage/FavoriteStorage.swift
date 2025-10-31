//
//  FavoriteStorage.swift
//  GhibliApp
//
//  Created by Pubudu Mihiranga on 2025-10-31.
//

import Foundation

protocol FavoriteStorage {
    func load() -> Set<String>
    func save(favoriteIDs: Set<String>)
}
