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
    @State private var isEditingReminder = false
    
    private let calendar = Calendar.current
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    var body: some View {
        VStack {
            DatePicker("Select a date", selection: $selectedDate, displayedComponents: [.date])
                .accessibilityLabel("Date Picker")
                .datePickerStyle(.graphical)
                .padding()
                .onChange(of: selectedDate) {
                    if hasReminder(on: selectedDate) {
                        HapticsManager.impact(style: .medium)
                    }
                }
            
            Text("📆 \(remindersThisWeek.count) reminder\(remindersThisWeek.count == 1 ? "" : "s") this week")
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
                        HapticsManager.impact(style: .light)
                        viewModel.setCompleted(for: reminder, to: newValue)
                    },
                    onSelect: {
                        handleReminderSelection(reminder)
                    }
                )
            }
        }
        .navigationTitle("Calendar")
        .sheet(isPresented: $isEditingReminder, onDismiss: handleSheetDismiss) {
            if let selected = viewModel.selectedReminder {
                EditReminderView(
                    reminder: selected,
                    onSave: viewModel.updateReminder,
                    onDelete: viewModel.removeReminder
                )
            }
        }
    }
    
    private var filteredReminders: [Reminder] {
        viewModel.reminders.filter {
            calendar.isDate($0.date, inSameDayAs: selectedDate)
        }
    }
    
    private var remindersThisWeek: [Reminder] {
        guard let weekRange = calendar.dateInterval(of: .weekOfMonth, for: selectedDate) else {
            return []
        }
        return viewModel.reminders.filter { weekRange.contains($0.date) }
    }
    
    private func hasReminder(on date: Date) -> Bool {
        viewModel.reminders.contains {
            calendar.isDate($0.date, inSameDayAs: date)
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        Self.dateFormatter.string(from: date)
    }
    
    private func handleReminderSelection(_ reminder: Reminder) {
        viewModel.selectedReminder = reminder
        isEditingReminder = true
        HapticsManager.impact(style: .light)
    }
    
    private func handleSheetDismiss() {
        viewModel.selectedReminder = nil
        HapticsManager.impact(style: .light)
    }
}


#Preview {
    CalendarView()
        .environmentObject(ReminderListComposer.makeViewModel())
}
