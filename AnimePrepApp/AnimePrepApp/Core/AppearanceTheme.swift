//
//  AppearanceTheme.swift
//  AnimePrepApp
//
//  Created by Pubudu Mihiranga on 2025-10-30.
//

import Foundation

enum AppearanceTheme: String, Identifiable, CaseIterable {
    case system
    case light
    case dark
    
    var id: Self { return self }
}
