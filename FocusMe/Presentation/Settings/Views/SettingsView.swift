//
//  SettingsView.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 12/05/25.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel: SettingsViewModel
    
    init(appSettings: AppSettings) {
        _viewModel = StateObject(wrappedValue: SettingsViewModel(appSettings: appSettings))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Appearance")) {
                    Picker("App Theme", selection: $viewModel.selectedTheme) {
                        ForEach(AppTheme.allCases) { theme in
                            Text(theme.displayName).tag(theme)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("Settings")
        }
    }
}
