//
//  CoreDataReminderRepository.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 27/04/25.
//

import CoreData
import Combine

final class CoreDataReminderRepository: ReminderRepository {
    private let manager: CoreDataManager
    
    init(manager: CoreDataManager = .shared) {
        self.manager = manager
    }
    
    func fetchReminders() -> AnyPublisher<[Reminder], Never> {
        let entities = manager.fetchAllReminders()
        let reminders = entities.map { entity in
            Reminder(
                id: entity.id ?? UUID(),
                title: entity.title ?? "",
                date: entity.dueDate ?? Date(),
                isCompleted: entity.isCompleted
            )
        }
        
        return Just(reminders)
            .eraseToAnyPublisher()
    }
    
    func addReminder(_ reminder: Reminder) {
        manager.saveReminder(
            id: reminder.id,
            title: reminder.title,
            dueDate: reminder.date,
            isCompleted: reminder.isCompleted,
            isViewed: true
        )
    }
    
    func removeReminder(_ reminder: Reminder) {
        guard let entity = manager.fetchAllReminders().first(where: { $0.id == reminder.id }) else {
            return
        }
        manager.deleteReminder(entity)
    }
    
    func markReminderAsViewed(_ reminder: Reminder) {
        guard let entity = manager.fetchAllReminders().first(where: { $0.id == reminder.id }) else {
            return
        }
        manager.updateReminder(entity, isViewed: true)
    }
    
    func countUnviewedReminders() -> Int {
        let entities = manager.fetchAllReminders()
        return entities.filter { !$0.isViewed }.count
    }
}
