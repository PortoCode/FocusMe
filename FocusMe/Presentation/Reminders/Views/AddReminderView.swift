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
    
    private var sanitizedTitle: String {
        title.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Reminder Details")) {
                    TextField("Title", text: $title)
                        .accessibilityLabel("Title")
                        .accessibilityHint("Enter the title of the reminder")
                    
                    LabeledTextEditor(label: "Description", text: $description)
                    
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
                        HapticsManager.impact(style: .heavy)
                        onSave(sanitizedTitle, description, dueDate)
                        dismiss()
                    }
                    .disabled(sanitizedTitle.isEmpty)
                    .accessibilityLabel("Save Reminder")
                    .accessibilityHint("Saves the reminder and closes the form")
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        HapticsManager.impact(style: .light)
                        dismiss()
                    }
                    .accessibilityLabel("Cancel")
                    .accessibilityHint("Dismisses the form without saving")
                }
            }
        }
    }
    
    struct LabeledTextEditor: View {
        let label: String
        @Binding var text: String
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(label)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .accessibilityHidden(true)
                
                TextEditor(text: $text)
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                    .accessibilityLabel(label)
                    .accessibilityHint("Enter the \(label.lowercased()) of the reminder")
            }
        }
    }
}

#Preview {
    AddReminderView { title, description, date in
        print("Mock Save: \(title), \(description), \(date)")
    }
}
