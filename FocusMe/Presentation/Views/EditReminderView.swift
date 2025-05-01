//
//  EditReminderView.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 30/04/25.
//

import SwiftUI

struct EditReminderView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String
    @State private var date: Date
    let reminder: Reminder
    let onSave: (Reminder) -> Void
    let onDelete: (Reminder) -> Void
    
    init(reminder: Reminder, onSave: @escaping (Reminder) -> Void, onDelete: @escaping (Reminder) -> Void) {
        self.reminder = reminder
        self._title = State(initialValue: reminder.title)
        self._date = State(initialValue: reminder.date)
        self.onSave = onSave
        self.onDelete = onDelete
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                DatePicker("Due Date", selection: $date)
                
                Section {
                    Button(role: .destructive) {
                        onDelete(reminder)
                        dismiss()
                    } label: {
                        Label("Delete Reminder", systemImage: "trash")
                    }
                }
            }
            .navigationTitle("Edit Reminder")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        var updated = reminder
                        updated.title = title
                        updated.date = date
                        onSave(updated)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
