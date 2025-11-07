//
//  FavoriteStorage.swift
//  AnimePrepApp
//
//  Created by Pubudu Mihiranga on 2025-10-30.
//

import Foundation

protocol FavoriteStorage {
    func load() -> Set<String>
    func save(favoriteIDs: Set<String>)
}
