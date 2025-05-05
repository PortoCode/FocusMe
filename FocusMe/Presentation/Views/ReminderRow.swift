//
//  ReminderRow.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 04/05/25.
//

import SwiftUI

struct ReminderRow: View {
    let reminder: Reminder
    let onToggle: (Bool) -> Void
    let onSelect: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(reminder.title)
                    .font(.subheadline)
                    .strikethrough(reminder.isCompleted)
                    .foregroundStyle(reminder.isCompleted ? .secondary : .primary)
                
                Text(reminder.date.formattedDateTime)
                    .font(.caption)
                    .strikethrough(reminder.isCompleted)
                    .foregroundStyle(reminder.isCompleted ? .secondary : .primary)
            }
            
            Spacer()
            
            Toggle("", isOn: Binding(
                get: { reminder.isCompleted },
                set: { onToggle($0) }
            ))
            .labelsHidden()
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
        .onTapGesture { onSelect() }
    }
}
