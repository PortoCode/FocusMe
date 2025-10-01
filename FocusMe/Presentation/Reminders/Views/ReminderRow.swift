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
    
    enum TouchState {
        case idle
        case pressing
        case draggedOutside
    }
    
    @State private var touchState: TouchState = .idle
    
    var body: some View {
        HStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(reminder.title)
                        .font(.subheadline)
                        .reminderStyle(isCompleted: reminder.isCompleted)
                    
                    Text(reminder.date.formattedDateTime)
                        .font(.caption)
                        .reminderStyle(isCompleted: reminder.isCompleted)
                }
                
                Spacer()
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        if touchState == .draggedOutside {
                            return
                        }
                        
                        let distance = dragDistance(from: value.startLocation, to: value.location)
                        
                        let threshold: CGFloat = 30
                        
                        if distance > threshold {
                            touchState = .draggedOutside
                        } else {
                            touchState = .pressing
                        }
                    }
                    .onEnded { _ in
                        if touchState == .pressing {
                            onSelect()
                        }
                        
                        touchState = .idle
                    }
            )
            
            Toggle("", isOn: Binding(
                get: { reminder.isCompleted },
                set: { onToggle($0) }
            ))
            .labelsHidden()
        }
        .padding(.vertical, 4)
        .listRowBackground(shouldHighlight ? Color.gray.opacity(0.2) : nil)
        .animation(.easeOut(duration: 0.1), value: shouldHighlight)
    }
    
    private var shouldHighlight: Bool {
        isHighlighted || touchState == .pressing
    }
    
    private func dragDistance(from start: CGPoint, to end: CGPoint) -> CGFloat {
        let dx = end.x - start.x
        let dy = end.y - start.y
        return sqrt(dx * dx + dy * dy)
    }
}

extension View {
    func reminderStyle(isCompleted: Bool) -> some View {
        self
            .strikethrough(isCompleted)
            .foregroundStyle(isCompleted ? .secondary : .primary)
    }
}

#Preview {
    List {
        ReminderRow(
            reminder: Reminder(
                id: UUID(),
                title: "Title 1",
                description: "",
                date: Date(),
                isCompleted: false
            ),
            isHighlighted: false,
            onToggle: { _ in },
            onSelect: {}
        )
        ReminderRow(
            reminder: Reminder(
                id: UUID(),
                title: "Title 2",
                description: "",
                date: Date(),
                isCompleted: false
            ),
            isHighlighted: true,
            onToggle: { _ in },
            onSelect: {}
        )
        ReminderRow(
            reminder: Reminder(
                id: UUID(),
                title: "Title 3",
                description: "",
                date: Date(),
                isCompleted: true
            ),
            isHighlighted: false,
            onToggle: { _ in },
            onSelect: {}
        )
    }
}
