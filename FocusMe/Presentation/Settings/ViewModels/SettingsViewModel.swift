//
//  SettingsViewModel.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 13/05/25.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {
    @Published var selectedTheme: AppTheme {
        didSet {
            appSettings.selectedTheme = selectedTheme
        }
    }
    
    private(set) var appSettings: AppSettings
    
    let appVersion: String = "1.0.0"
    
    init(appSettings: AppSettings) {
        self.appSettings = appSettings
        self.selectedTheme = appSettings.selectedTheme
    }
}

enum SettingsSection: CaseIterable {
    case appearance
    case about
    
    var displayTitle: String {
        switch self {
        case .appearance: return "Appearance"
        case .about: return "About"
        }
    }
}
