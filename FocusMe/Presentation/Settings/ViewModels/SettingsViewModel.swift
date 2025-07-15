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
    @Published var notificationsEnabled: Bool = false
    @Published var showNotificationAlert: Bool = false
    
    private(set) var appSettings: AppSettings
    
    let appVersion: String = "1.0.0"
    
    init(appSettings: AppSettings) {
        self.appSettings = appSettings
        self.selectedTheme = appSettings.selectedTheme
    }
    
    func checkNotificationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.notificationsEnabled = settings.authorizationStatus == .authorized
            }
        }
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            DispatchQueue.main.async {
                self.notificationsEnabled = granted
                if !granted {
                    self.showNotificationAlert = true
                }
            }
        }
    }
}

enum SettingsSection: CaseIterable, Identifiable {
    case appearance
    case notifications
    case about
    
    var id: Self { self }
    
    var displayTitle: String {
        switch self {
        case .appearance: return "Appearance"
        case .notifications: return "Notifications"
        case .about: return "About"
        }
    }
}
