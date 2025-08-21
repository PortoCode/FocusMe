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
                TextField("Title", text: $title)
                VStack(alignment: .leading) {
                    Text("Description")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    TextEditor(text: $description)
                        .frame(height: 100)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                }
                DatePicker("Due Date", selection: $dueDate)
                    .padding()
            }
            .navigationTitle("New Reminder")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(title, description, dueDate)
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

#Preview {
    AddReminderView { title, description, date in
        print("Mock Save: \(title), \(description), \(date)")
    }
}
