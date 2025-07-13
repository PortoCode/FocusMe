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
                ForEach(SettingsSection.allCases) { section in
                    Section(header: Text(section.displayTitle)) {
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
            AppearanceSection(selectedTheme: $viewModel.selectedTheme)
            
        case .about:
            AboutSection(appVersion: viewModel.appVersion)
        }
    }
    
    private struct AppearanceSection: View {
        @Binding var selectedTheme: AppTheme
        
        var body: some View {
            Picker("App Theme", selection: $selectedTheme) {
                ForEach(AppTheme.allCases) { theme in
                    Text(theme.displayName).tag(theme)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    private struct AboutSection: View {
        let appVersion: String
        
        var body: some View {
            Text("App Version: \(appVersion)")
            NavigationLink("Privacy Policy", destination: Text("Privacy Policy Here"))
            NavigationLink("Contact Support", destination: Text("Support View"))
        }
    }
}
