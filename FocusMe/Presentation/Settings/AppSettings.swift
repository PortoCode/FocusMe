//
//  AppSettings.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 13/05/25.
//

import SwiftUI

class AppSettings: ObservableObject {
    @Published var selectedTheme: AppTheme = .system
}

enum AppTheme: String, CaseIterable, Identifiable {
    case system
    case light
    case dark
    
    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .system: return "System Default"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }
    
    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}
