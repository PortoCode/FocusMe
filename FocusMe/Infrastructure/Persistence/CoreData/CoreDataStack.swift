//
//  CoreDataStack.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 27/04/25.
//

import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()
    
    let container: NSPersistentContainer
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    private init() {
        container = NSPersistentContainer(name: "ReminderEntity")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("CoreDataStack: Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
