//
//  GhibliAppApp.swift
//  GhibliApp
//
//  Created by Pubudu Mihiranga on 2025-10-31.
//

import SwiftUI
import SwiftData

@main
struct GhibliAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Favorite.self)
        }
    }
}
