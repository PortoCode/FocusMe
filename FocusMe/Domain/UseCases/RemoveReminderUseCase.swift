//
//  RemoveReminderUseCase.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 28/04/25.
//

import Foundation

final class RemoveReminderUseCase {
    private let repository: ReminderRepository
    
    init(repository: ReminderRepository) {
        self.repository = repository
    }
    
    func execute(reminder: Reminder) {
        repository.removeReminder(reminder)
    }
}
