//
//  SettingsView.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 12/05/25.
//

import SwiftUI
import StoreKit

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
                AppReviewSection(triggerLightHapticFeedback: triggerLightHapticFeedback,
                                 requestAppReview: requestAppReview)
                FooterSection()
            }
            .navigationTitle("Settings")
            .onAppear {
                viewModel.checkNotificationStatus()
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                viewModel.checkNotificationStatus()
            }
        }
    }
    
    @ViewBuilder
    private func sectionView(for section: SettingsSection) -> some View {
        switch section {
        case .appearance:
            AppearanceSection(selectedTheme: $viewModel.selectedTheme)
            
        case .notifications:
            NotificationsSection(viewModel: viewModel)
            
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
            .accessibilityLabel("Choose app theme")
        }
    }
    
    private struct NotificationsSection: View {
        @ObservedObject var viewModel: SettingsViewModel
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Toggle("Notifications Enabled", isOn: Binding<Bool>(
                    get: { viewModel.notificationsEnabled },
                    set: { _ in viewModel.requestNotificationPermission() }
                ))
                .disabled(true)
                
                Button {
                    viewModel.requestNotificationPermission()
                } label: {
                    Label("Enable Notifications", systemImage: "bell.badge")
                }
                .accessibilityLabel("Enable Notifications")
                .accessibilityHint("Double tap to request notification permission.")
                
                Button {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    Label("Open System Settings", systemImage: "gear")
                }
                .accessibilityLabel("Open System Settings")
                .accessibilityHint("Double tap to open iOS Settings.")
                
                Text("The app requires notifications to function properly.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            .alert("Notifications Disabled", isPresented: $viewModel.showNotificationAlert) {
                Button("Open Settings") {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Please enable notifications in system settings for the app to work correctly.")
            }
        }
    }
    
    private struct AboutSection: View {
        let appVersion: String
        
        var body: some View {
            Text("App Version: \(appVersion)")
            NavigationLink("Privacy Policy", destination: PrivacyPolicyView())
                .accessibilityLabel("Privacy Policy")
            NavigationLink("Contact Support", destination: ContactSupportView())
                .accessibilityLabel("Contact Support")
        }
    }
    
    private struct AppReviewSection: View {
        let triggerLightHapticFeedback: () -> Void
        let requestAppReview: () -> Void
        
        var body: some View {
            Section {
                Button {
                    triggerLightHapticFeedback()
                    requestAppReview()
                } label: {
                    Label("Rate the App", systemImage: "star.bubble")
                }
                .accessibilityLabel("Rate the app")
                .accessibilityHint("Double tap to rate the app on the App Store.")
            }
        }
    }
    
    private struct FooterSection: View {
        var body: some View {
            Section {
                VStack(spacing: 8) {
                    Image("focus-me-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    
                    Text("© 2025 FocusMe Inc.")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity)
            }
            .listRowBackground(Color(UIColor.systemGroupedBackground))
        }
    }
    
    private func triggerLightHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
    }
    
    private func requestAppReview() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            AppStore.requestReview(in: scene)
        }
    }
}

#Preview("Dark Mode") {
    SettingsView(appSettings: {
        let mock = AppSettings()
        mock.selectedTheme = .dark
        return mock
    }())
    .preferredColorScheme(.dark)
}

#Preview("Light Theme") {
    SettingsView(appSettings: {
        let mock = AppSettings()
        mock.selectedTheme = .light
        return mock
    }())
}
