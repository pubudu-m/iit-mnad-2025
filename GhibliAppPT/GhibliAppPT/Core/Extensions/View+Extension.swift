//
//  View+Extension.swift
//  GhibliAppPT
//
//  Created by Pubudu Mihiranga on 2025-11-08.
//

import SwiftUI

extension View {
    func setAppearanceTheme() -> some View {
        modifier(AppearanceThemeViewModifier())
    }
}

struct AppearanceThemeViewModifier: ViewModifier {
    @AppStorage("appearanceTheme")
    private var appearanceTheme: AppearanceTheme = .system
    
    func body(content: Content) -> some View {
        content
            .preferredColorScheme(colorScheme())
    }
    
    func colorScheme() -> ColorScheme? {
        switch appearanceTheme {
            case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
