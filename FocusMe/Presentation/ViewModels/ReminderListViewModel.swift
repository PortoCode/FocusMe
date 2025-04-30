//
//  ReminderListViewModel.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 24/04/25.
//

import Foundation
import Combine

final class ReminderListViewModel: ObservableObject {
    @Published private(set) var reminders: [Reminder] = []
    
    private let fetchRemindersUseCase: FetchRemindersUseCase
    private let addReminderUseCase: AddReminderUseCase
    private let removeReminderUseCase: RemoveReminderUseCase
    private let updateReminderUseCase: UpdateReminderUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(fetchRemindersUseCase: FetchRemindersUseCase,
         addReminderUseCase: AddReminderUseCase,
         removeReminderUseCase: RemoveReminderUseCase,
         updateReminderUseCase: UpdateReminderUseCase) {
        self.fetchRemindersUseCase = fetchRemindersUseCase
        self.addReminderUseCase = addReminderUseCase
        self.removeReminderUseCase = removeReminderUseCase
        self.updateReminderUseCase = updateReminderUseCase
        loadReminders()
    }
    
    func loadReminders() {
        fetchRemindersUseCase.execute()
            .receive(on: DispatchQueue.main)
            .assign(to: &$reminders)
    }
    
    func addReminder(title: String, dueDate: Date) {
        let newReminder = Reminder(id: UUID(), title: title, date: dueDate, isCompleted: false)
        addReminderUseCase.execute(reminder: newReminder)
        NotificationManager.shared.scheduleNotification(for: newReminder)
        loadReminders()
    }
    
    func removeReminder(at offsets: IndexSet) {
        offsets.forEach { index in
            let reminder = reminders[index]
            removeReminderUseCase.execute(reminder: reminder)
            NotificationManager.shared.cancelNotification(for: reminder)
        }
        loadReminders()
    }
    
    func toggleCompleted(for reminder: Reminder) {
        var reminderUpdated = reminder
        reminderUpdated.isCompleted.toggle()
        updateReminderUseCase.execute(reminder: reminderUpdated)
        loadReminders()
    }
}
