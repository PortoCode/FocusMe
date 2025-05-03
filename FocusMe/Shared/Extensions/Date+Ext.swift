//
//  Date+Ext.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 02/05/25.
//

import Foundation

extension Date {
    var formattedDateTime: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter.string(from: self)
    }
}
