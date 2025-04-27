//
//  NotificationManager.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 26/04/25.
//

import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification authorization error: \(error.localizedDescription)")
            } else if granted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied.")
            }
        }
    }
    
    func scheduleNotification(for reminder: Reminder) {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = reminder.title
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: reminder.id.uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled for reminder: \(reminder.title)")
            }
        }
    }
}
