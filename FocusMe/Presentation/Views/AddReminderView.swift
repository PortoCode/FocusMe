//
//  AddReminderView.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 26/04/25.
//

import SwiftUI

struct AddReminderView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    @State private var dueDate: Date = Date()
    let onSave: (String, Date) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                DatePicker("Due Date", selection: $dueDate)
            }
            .navigationTitle("New Reminder")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(title, dueDate)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
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
