//
//  ReminderListView.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 24/04/25.
//

import SwiftUI

struct ReminderListView: View {
    @EnvironmentObject private var viewModel: ReminderListViewModel
    @State private var sheetPresentationState = SheetPresentationState()
    
    var body: some View {
        NavigationStack {
            reminderList
                .navigationTitle("Reminders")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        addButton
                    }
                }
                .sheet(isPresented: $sheetPresentationState.isPresented, onDismiss: handleSheetDismiss) {
                    sheetContent
                }
        }
    }
    
    private var reminderList: some View {
        List {
            ForEach(viewModel.sortedReminders) { reminder in
                ReminderRow(
                    reminder: reminder,
                    isHighlighted: sheetPresentationState.pressedReminderId == reminder.id,
                    onToggle: { newValue in
                        handleToggle(for: reminder, to: newValue)
                    },
                    onSelect: {
                        handleReminderSelection(reminder)
                    }
                )
            }
            .onDelete(perform: viewModel.removeReminder)
        }
    }
    
    private var addButton: some View {
        Button(action: presentAddSheet) {
            Image(systemName: "plus")
        }
    }
    
    @ViewBuilder
    private var sheetContent: some View {
        if let selected = viewModel.selectedReminder {
            EditReminderView(
                reminder: selected,
                onSave: viewModel.updateReminder,
                onDelete: viewModel.removeReminder
            )
            .onAppear {
                scheduleHighlightRemoval()
            }
        } else {
            AddReminderView { title, description, dueDate in
                viewModel.addReminder(title: title, description: description, dueDate: dueDate)
            }
        }
    }
    
    private func handleToggle(for reminder: Reminder, to newValue: Bool) {
        viewModel.setCompleted(for: reminder, to: newValue)
        HapticsManager.impact(style: .light)
    }
    
    private func handleReminderSelection(_ reminder: Reminder) {
        sheetPresentationState.pressedReminderId = reminder.id
        viewModel.selectedReminder = reminder
        sheetPresentationState.isPresented = true
        HapticsManager.impact(style: .light)
    }
    
    private func handleSheetDismiss() {
        viewModel.selectedReminder = nil
        sheetPresentationState.pressedReminderId = nil
        HapticsManager.impact(style: .light)
    }
    
    private func presentAddSheet() {
        viewModel.selectedReminder = nil
        sheetPresentationState.isPresented = true
        HapticsManager.impact(style: .light)
    }
    
    private func scheduleHighlightRemoval() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            sheetPresentationState.pressedReminderId = nil
        }
    }
}

struct SheetPresentationState {
    var isPresented = false
    var pressedReminderId: UUID? = nil
}
