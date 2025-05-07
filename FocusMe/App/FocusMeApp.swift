//
//  FocusMeApp.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 24/04/25.
//

import SwiftUI

@main
struct FocusMeApp: App {
    init() {
        NotificationManager.shared.requestAuthorization()
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
