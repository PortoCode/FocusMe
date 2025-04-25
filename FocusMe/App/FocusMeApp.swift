//
//  FocusMeApp.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 24/04/25.
//

import SwiftUI

@main
struct FocusMeApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = MockReminderRepository()
            let fetchUseCase = FetchRemindersUseCase(repository: repository)
            let viewModel = ReminderListViewModel(fetchRemindersUseCase: fetchUseCase)
            ReminderListView(viewModel: viewModel)
        }
    }
}
