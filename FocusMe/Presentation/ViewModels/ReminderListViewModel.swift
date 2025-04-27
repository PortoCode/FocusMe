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
    
    private let fetchRemindersUseCase: FetchRemindersUseCase
    private let addReminderUseCase: AddReminderUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(fetchRemindersUseCase: FetchRemindersUseCase, addReminderUseCase: AddReminderUseCase) {
        self.fetchRemindersUseCase = fetchRemindersUseCase
        self.addReminderUseCase = addReminderUseCase
        loadReminders()
    }
    
    func loadReminders() {
        fetchRemindersUseCase.execute()
            .receive(on: DispatchQueue.main)
            .assign(to: &$reminders)
    }
    
    func addReminder(title: String) {
        let newReminder = Reminder(id: UUID(), title: title, date: Date(), isCompleted: false)
        addReminderUseCase.execute(reminder: newReminder)
        NotificationManager.shared.scheduleNotification(for: newReminder)
        loadReminders()
    }
}
