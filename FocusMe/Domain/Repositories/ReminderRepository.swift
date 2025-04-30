//
//  ReminderRepository.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 24/04/25.
//

import Combine

protocol ReminderRepository {
    func fetchReminders() -> AnyPublisher<[Reminder], Never>
    func addReminder(_ reminder: Reminder)
    func removeReminder(_ reminder: Reminder)
    func updateReminder(_ reminder: Reminder)
}
