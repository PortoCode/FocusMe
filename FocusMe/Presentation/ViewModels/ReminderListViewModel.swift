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
    @Published var selectedReminder: Reminder?
    
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
    
    func addReminder(title: String, description: String, dueDate: Date) {
        let newReminder = Reminder(id: UUID(), title: title, description: description, date: dueDate, isCompleted: false)
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
    
    func removeReminder(_ reminder: Reminder) {
        removeReminderUseCase.execute(reminder: reminder)
        NotificationManager.shared.cancelNotification(for: reminder)
        loadReminders()
    }
    
    func setCompleted(for reminder: Reminder, to newValue: Bool) {
        var reminderUpdated = reminder
        reminderUpdated.isCompleted = newValue
        updateReminderUseCase.execute(reminder: reminderUpdated)
        loadReminders()
    }
    
    func updateReminder(_ reminder: Reminder) {
        updateReminderUseCase.execute(reminder: reminder)
        NotificationManager.shared.scheduleNotification(for: reminder)
        loadReminders()
    }
}
