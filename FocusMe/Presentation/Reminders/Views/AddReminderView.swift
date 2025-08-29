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
    @State private var description: String = ""
    @State private var dueDate: Date = Date()
    let onSave: (String, String, Date) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Reminder Details")) {
                    TextField("Title", text: $title)
                        .accessibilityLabel("Title")
                        .accessibilityHint("Enter the title of the reminder")
                    
                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .accessibilityHidden(true)
                        
                        TextEditor(text: $description)
                            .frame(height: 100)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                            .accessibilityLabel("Description")
                            .accessibilityHint("Enter the description of the reminder")
                    }
                    
                    DatePicker("Due Date", selection: $dueDate)
                        .padding()
                        .accessibilityLabel("Due Date")
                        .accessibilityHint("Choose the due date for the reminder")
                }
            }
            .navigationTitle("New Reminder")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(title, description, dueDate)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                    .accessibilityLabel("Save Reminder")
                    .accessibilityHint("Saves the reminder and closes the form")
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .accessibilityLabel("Cancel")
                    .accessibilityHint("Dismisses the form without saving")
                }
            }
        }
    }
}

#Preview {
    AddReminderView { title, description, date in
        print("Mock Save: \(title), \(description), \(date)")
    }
}
