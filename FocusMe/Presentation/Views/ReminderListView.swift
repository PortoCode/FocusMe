//
//  ReminderListView.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 24/04/25.
//

import SwiftUI

struct ReminderListView: View {
    @StateObject private var viewModel: ReminderListViewModel
    
    init(viewModel: ReminderListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            List(viewModel.reminders) { reminder in
                VStack(alignment: .leading) {
                    Text(reminder.title)
                        .font(.headline)
                    Text("\(reminder.date.formatted())")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Reminders")
        }
    }
}
