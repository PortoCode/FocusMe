//
//  MainTabView.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 06/05/25.
//

import SwiftUI

enum TabSelection: Hashable {
    case reminders
    case calendar
    case settings
}

struct MainTabView: View {
    @StateObject private var viewModel = ReminderListComposer.makeViewModel()
    @State private var selectedTab: TabSelection = .reminders
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Reminders",
                systemImage: "list.bullet",
                value: TabSelection.reminders) {
                ReminderListView()
            }
            
            Tab("Calendar",
                systemImage: "calendar",
                value: TabSelection.calendar) {
                CalendarView()
            }
            
            Tab("Settings",
                systemImage: "gear",
                value: TabSelection.settings) {
                SettingsView()
            }
        }
        .environmentObject(viewModel)
    }
}
