//
//  MainTabView.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 06/05/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ReminderListFactory.make()
                .tabItem {
                    Label("Reminders", systemImage: "list.bullet")
                }
            
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
        }
    }
}

