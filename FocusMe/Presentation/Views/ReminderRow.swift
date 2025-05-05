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
                    .onChanged { value in
                        if touchState == .draggedOutside {
                            return
                        }
                        
                        let displacement = CGSize(
                            width: value.location.x - value.startLocation.x,
                            height: value.location.y - value.startLocation.y
                        )
                        
                        let distance = sqrt(displacement.width * displacement.width +
                                            displacement.height * displacement.height)
                        
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
}
