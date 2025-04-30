//
//  UpdateReminderUseCase.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 30/04/25.
//

import Foundation

final class UpdateReminderUseCase {
    private let repository: ReminderRepository
    
    init(repository: ReminderRepository) {
        self.repository = repository
    }
    
    func execute(reminder: Reminder) {
        repository.updateReminder(reminder)
    }
}
