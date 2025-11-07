//
//  GhibliAppPTApp.swift
//  GhibliAppPT
//
//  Created by Pubudu Mihiranga on 2025-11-01.
//

import SwiftUI
import SwiftData

@main
struct GhibliAppPTApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Favorite.self)
        }
    }
}
