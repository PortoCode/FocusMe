//
//  CalendarView.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 06/05/25.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject private var viewModel: ReminderListViewModel
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            DatePicker("Select a date", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .padding()
            
            Text("Reminders for \(formattedDate(selectedDate))")
                .font(.headline)
                .padding(.top)
            
            List(filteredReminders) { reminder in
                ReminderRow(
                    reminder: reminder,
                    isHighlighted: false,
                    onToggle: { newValue in
                        viewModel.setCompleted(for: reminder, to: newValue)
                    },
                    onSelect: {
                    }
                )
            }
        }
        .navigationTitle("Calendar")
    }
    
    private var filteredReminders: [Reminder] {
        viewModel.reminders.filter {
            Calendar.current.isDate($0.date, inSameDayAs: selectedDate)
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
