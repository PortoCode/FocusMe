//
//  FetchRemindersUseCase.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 24/04/25.
//

import Combine

final class FetchRemindersUseCase {
    private let repository: ReminderRepository
    
    init(repository: ReminderRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[Reminder], Never> {
        repository.fetchReminders()
    }
}
