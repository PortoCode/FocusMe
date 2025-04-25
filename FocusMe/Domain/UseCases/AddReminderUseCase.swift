//
//  AddReminderUseCase.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 24/04/25.
//

import Foundation

final class AddReminderUseCase {
    private let repository: ReminderRepository
    
    init(repository: ReminderRepository) {
        self.repository = repository
    }
    
    func execute(title: String, date: Date) {
        let reminder = Reminder(id: UUID(), title: title, date: date, isCompleted: false)
        repository.addReminder(reminder)
    }
}
