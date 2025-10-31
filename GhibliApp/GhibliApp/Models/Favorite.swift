//
//  Favorite.swift
//  GhibliApp
//
//  Created by Pubudu Mihiranga on 2025-10-31.
//

import SwiftData

@Model
final class Favorite {
    @Attribute(.unique) var filmID: String

    init(filmID: String) {
        self.filmID = filmID
    }
}
