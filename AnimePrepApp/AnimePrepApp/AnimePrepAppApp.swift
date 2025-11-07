//
//  AnimePrepAppApp.swift
//  AnimePrepApp
//
//  Created by Pubudu Mihiranga on 2025-10-29.
//

import SwiftUI
import SwiftData

@main
struct AnimePrepAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Favorite.self)
        }
    }
}
