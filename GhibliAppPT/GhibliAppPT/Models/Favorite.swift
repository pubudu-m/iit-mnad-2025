//
//  Favorite.swift
//  GhibliAppPT
//
//  Created by Pubudu Mihiranga on 2025-11-01.
//

import Foundation
import SwiftData

@Model
final class Favorite {
    @Attribute(.unique) var filmID: String

    init(filmID: String) {
        self.filmID = filmID
    }
}
