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
                .onChange(of: selectedDate) {
                    if hasReminder(on: selectedDate) {
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    }
                }
            
            Text("📆 \(remindersThisWeek.count) reminders this week")
                .font(.caption)
                .foregroundColor(.secondary)
            
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
                    onSelect: {}
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
    
    private var remindersThisWeek: [Reminder] {
        let calendar = Calendar.current
        guard let weekRange = calendar.dateInterval(of: .weekOfMonth, for: selectedDate) else {
            return []
        }
        return viewModel.reminders.filter { weekRange.contains($0.date) }
    }
    
    private func hasReminder(on date: Date) -> Bool {
        viewModel.reminders.contains {
            Calendar.current.isDate($0.date, inSameDayAs: date)
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    CalendarView()
        .environmentObject(ReminderListComposer.makeViewModel())
}
