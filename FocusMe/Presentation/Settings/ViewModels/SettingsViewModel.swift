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
    
    init(appSettings: AppSettings) {
        self.appSettings = appSettings
        self.selectedTheme = appSettings.selectedTheme
    }
}
