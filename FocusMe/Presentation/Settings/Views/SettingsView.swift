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
                ForEach(SettingsSection.allCases, id: \.self) { section in
                    Section(header: Text(section.title)) {
                        sectionView(for: section)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    @ViewBuilder
    private func sectionView(for section: SettingsSection) -> some View {
        switch section {
        case .appearance:
            Picker("App Theme", selection: $viewModel.selectedTheme) {
                ForEach(AppTheme.allCases) { theme in
                    Text(theme.displayName).tag(theme)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
        case .about:
            Text("App Version: \(viewModel.appVersion)")
            NavigationLink("Privacy Policy", destination: Text("Privacy Policy Here"))
            NavigationLink("Contact Support", destination: Text("Support View"))
        }
    }
}
