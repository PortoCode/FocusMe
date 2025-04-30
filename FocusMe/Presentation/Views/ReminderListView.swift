//
//  ReminderListView.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 24/04/25.
//

import SwiftUI

struct ReminderListView: View {
    @StateObject private var viewModel: ReminderListViewModel
    @State private var showingAdd = false
    
    init(viewModel: ReminderListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.reminders) { reminder in
                    HStack {
                        Image(systemName: reminder.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(reminder.isCompleted ? .green : .gray)
                        Text(reminder.title)
                            .strikethrough(reminder.isCompleted)
                            .foregroundStyle(reminder.isCompleted ? .secondary : .primary)
                    }
                    .onTapGesture {
                        viewModel.toggleCompleted(for: reminder)
                    }
                }
                .onDelete(perform: viewModel.removeReminder)
            }
            .navigationTitle("Reminders")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showingAdd = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAdd) {
                AddReminderView { title, dueDate in
                    viewModel.addReminder(title: title, dueDate: dueDate)
                }
            }
        }
    }
}
