//
//  MainTabView.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 06/05/25.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var viewModel = ReminderListComposer.makeViewModel()
    
    var body: some View {
        TabView {
            ReminderListView()
                .tabItem {
                    Label("Reminders", systemImage: "list.bullet")
                }
            
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
        }
        .environmentObject(viewModel)
    }
}
