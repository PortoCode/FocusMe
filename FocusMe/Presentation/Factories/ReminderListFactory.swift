//
//  ReminderListFactory.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 27/04/25.
//

import Foundation

enum ReminderListFactory {
    static func make() -> ReminderListView {
        let repository = MockReminderRepository()
        let fetchUseCase = FetchRemindersUseCase(repository: repository)
        let addUseCase = AddReminderUseCase(repository: repository)
        let removeUseCase = RemoveReminderUseCase(repository: repository)
        let viewModel = ReminderListViewModel(
            fetchRemindersUseCase: fetchUseCase,
            addReminderUseCase: addUseCase,
            removeReminderUseCase: removeUseCase
        )
        return ReminderListView(viewModel: viewModel)
    }
}
