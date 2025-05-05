//
//  ReminderRow.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 04/05/25.
//

import SwiftUI

struct ReminderRow: View {
    let reminder: Reminder
    let isHighlighted: Bool
    let onToggle: (Bool) -> Void
    let onSelect: () -> Void
    
    @State private var isPressing = false
    
    var body: some View {
        HStack {
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
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        isPressing = true
                    }
                    .onEnded { _ in
                        isPressing = false
                        onSelect()
                    }
            )
            
            Toggle("", isOn: Binding(
                get: { reminder.isCompleted },
                set: { onToggle($0) }
            ))
            .labelsHidden()
        }
        .padding(.vertical, 4)
        .listRowBackground(isPressing || isHighlighted ? Color.gray.opacity(0.2) : nil)
    }
}
