//
//  MockReminderRepository.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 25/04/25.
//

import Combine

final class MockReminderRepository: ReminderRepository {
    private var reminders: CurrentValueSubject<[Reminder], Never> = .init([])
    
    func fetchReminders() -> AnyPublisher<[Reminder], Never> {
        reminders.eraseToAnyPublisher()
    }
    
    func addReminder(_ reminder: Reminder) {
        var current = reminders.value
        current.append(reminder)
        reminders.send(current)
    }
    
    func removeReminder(_ reminder: Reminder) {
        let updated = reminders.value.filter { $0.id != reminder.id }
        reminders.send(updated)
    }
}
