//
//  Reminder.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 24/04/25.
//

import Foundation

struct Reminder: Identifiable, Equatable {
    let id: UUID
    var title: String
    var description: String
    var date: Date
    var isCompleted: Bool
}
