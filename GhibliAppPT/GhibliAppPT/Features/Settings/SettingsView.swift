//
//  SettingsView.swift
//  GhibliAppPT
//
//  Created by Pubudu Mihiranga on 2025-11-08.
//

import SwiftUI

enum AppearanceTheme: String, CaseIterable, Identifiable {
    case system = "System"
    case dark = "Dark"
    case light = "Light"
    
    var id: Self { return self }
}

struct SettingsView: View {
    @AppStorage("appearanceTheme")
    private var appearanceTheme: AppearanceTheme = .system
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Appearance", selection: $appearanceTheme) {
                    ForEach(AppearanceTheme.allCases) { item in
                        Text(item.rawValue).tag(item)
                    }
                }
                .pickerStyle(.inline)
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
