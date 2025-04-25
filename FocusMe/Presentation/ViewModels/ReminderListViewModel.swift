//
//  ReminderListViewModel.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 24/04/25.
//

import Foundation
import Combine

final class ReminderListViewModel: ObservableObject {
    @Published var reminders: [Reminder] = []
    
    private let fetchRemindersUseCase: FetchRemindersUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(fetchRemindersUseCase: FetchRemindersUseCase) {
        self.fetchRemindersUseCase = fetchRemindersUseCase
        loadReminders()
    }
    
    func loadReminders() {
        fetchRemindersUseCase.execute()
            .receive(on: DispatchQueue.main)
            .assign(to: &$reminders)
    }
}
