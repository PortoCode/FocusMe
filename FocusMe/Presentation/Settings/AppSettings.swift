//
//  AppSettings.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 13/05/25.
//

import SwiftUI

final class AppSettings: ObservableObject {
    @Published var selectedTheme: AppTheme {
        didSet {
            saveTheme()
        }
    }
    
    private let themeKey = "selectedAppTheme"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: themeKey),
           let savedTheme = try? JSONDecoder().decode(AppTheme.self, from: data) {
            self.selectedTheme = savedTheme
        } else {
            self.selectedTheme = .system
        }
    }
    
    private func saveTheme() {
        if let data = try? JSONEncoder().encode(selectedTheme) {
            UserDefaults.standard.set(data, forKey: themeKey)
        }
    }
}

enum AppTheme: String, CaseIterable, Identifiable, Codable {
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
