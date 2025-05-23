//
//  CoreDataManager.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 27/04/25.
//

import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let context: NSManagedObjectContext
    
    private init(context: NSManagedObjectContext = CoreDataStack.shared.context) {
        self.context = context
    }
    
    func saveReminder(id: UUID, title: String, description: String, dueDate: Date, isCompleted: Bool = false, isViewed: Bool = false) {
        let reminder = ReminderEntity(context: context)
        reminder.id = id
        reminder.title = title
        reminder.reminderDescription = description
        reminder.dueDate = dueDate
        reminder.isCompleted = isCompleted
        reminder.isViewed = isViewed
        saveContext()
    }
    
    func fetchAllReminders() -> [ReminderEntity] {
        let request: NSFetchRequest<ReminderEntity> = ReminderEntity.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("CoreDataManager: Failed to fetch reminders: \(error)")
            return []
        }
    }
    
    func deleteReminder(_ reminder: ReminderEntity) {
        context.delete(reminder)
        saveContext()
    }
    
    func updateReminder(with reminder: Reminder) {
        guard let entity = fetchAllReminders().first(where: { $0.id == reminder.id }) else { return }
        entity.title = reminder.title
        entity.reminderDescription = reminder.description
        entity.dueDate = reminder.date
        entity.isCompleted = reminder.isCompleted
        saveContext()
    }
    
    private func saveContext() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("CoreDataManager: Failed to save context: \(error)")
        }
    }
}
