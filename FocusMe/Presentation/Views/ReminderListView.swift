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
                    ReminderRow(
                        reminder: reminder,
                        onToggle: { newValue in
                            viewModel.setCompleted(for: reminder, to: newValue)
                            triggerHaptic()
                        },
                        onSelect: {
                            viewModel.selectedReminder = reminder
                            showingAdd = true
                        }
                    )
                }
                .onDelete(perform: viewModel.removeReminder)
            }
            .navigationTitle("Reminders")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showingAdd = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAdd, onDismiss: {
                viewModel.selectedReminder = nil
            }) {
                if let selected = viewModel.selectedReminder {
                    EditReminderView(
                        reminder: selected,
                        onSave: { updatedReminder in
                            viewModel.updateReminder(updatedReminder)
                        },
                        onDelete: { reminderToDelete in
                            viewModel.removeReminder(reminderToDelete)
                        }
                    )
                } else {
                    AddReminderView { title, description, dueDate in
                        viewModel.addReminder(title: title, description: description, dueDate: dueDate)
                    }
                }
            }
        }
    }
    
    private func triggerHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
    }
}
