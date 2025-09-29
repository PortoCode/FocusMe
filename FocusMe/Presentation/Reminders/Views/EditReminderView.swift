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
    @State private var description: String
    @State private var date: Date
    
    let reminder: Reminder
    let onSave: (Reminder) -> Void
    let onDelete: (Reminder) -> Void
    
    init(reminder: Reminder, onSave: @escaping (Reminder) -> Void, onDelete: @escaping (Reminder) -> Void) {
        self.reminder = reminder
        self._title = State(initialValue: reminder.title)
        self._date = State(initialValue: reminder.date)
        self._description = State(initialValue: reminder.description)
        self.onSave = onSave
        self.onDelete = onDelete
    }
    
    private var updatedReminder: Reminder {
        var updated = reminder
        updated.title = title
        updated.description = description
        updated.date = date
        return updated
    }
    
    private var hasChanges: Bool {
        title != reminder.title ||
        description != reminder.description ||
        date != reminder.date
    }
    
    var body: some View {
        NavigationStack {
            reminderForm
                .navigationTitle("Edit Reminder")
                .toolbar {
                    reminderToolbar
                }
        }
    }
    
    private var reminderForm: some View {
        Form {
            TextField("Title", text: $title)
            
            ZStack(alignment: .topLeading) {
                if description.isEmpty {
                    Text("Description")
                        .foregroundColor(.gray)
                        .padding(.top, 12)
                        .padding(.horizontal, 8)
                }
                TextEditor(text: $description)
                    .frame(height: 100)
                    .padding(4)
                    .accessibilityLabel("Reminder Description")
            }
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3))
            )
            
            DatePicker("Due Date", selection: $date)
            
            Section {
                Button(role: .destructive) {
                    HapticsManager.impact(style: .heavy)
                    onDelete(reminder)
                    dismiss()
                } label: {
                    Label("Delete Reminder", systemImage: "trash")
                }
            }
        }
    }
    
    @ToolbarContentBuilder
    private var reminderToolbar: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button("Save") {
                HapticsManager.impact(style: .heavy)
                onSave(updatedReminder)
                dismiss()
            }
            .disabled(!hasChanges)
        }
        
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel") {
                HapticsManager.impact(style: .light)
                dismiss()
            }
        }
    }
}

#Preview {
    let reminder = Reminder(id: UUID(), title: "Sample Reminder", description: "", date: Date(), isCompleted: false)
    EditReminderView(reminder: reminder, onSave: { _ in }, onDelete: { _ in })
}
