//
//  NotificationManager.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 26/04/25.
//

import UserNotifications

final class NotificationManager: NSObject {
    static let shared = NotificationManager()
    
    private override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("❌ Notification authorization error: \(error.localizedDescription)")
            } else if granted {
                print("✅ Notification permission granted.")
            } else {
                print("⚠️ Notification permission denied.")
            }
        }
    }
    
    func scheduleNotification(for reminder: Reminder) {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = reminder.title
        content.sound = .default
        
        let timeInterval = reminder.date.timeIntervalSinceNow
        
        if timeInterval > 0 {
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
            
            let request = UNNotificationRequest(
                identifier: reminder.id.uuidString,
                content: content,
                trigger: trigger
            )
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("❌ Failed to schedule notification: \(error.localizedDescription)")
                } else {
                    print("✅ Notification scheduled for reminder: \(reminder.title)")
                }
            }
        } else {
            print("⚠️ Selected time is in the past. Notification will not be scheduled.")
        }
    }
    
    func cancelNotification(for reminder: Reminder) {
        let id = reminder.id.uuidString
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [id])
        print("🔕 Notification canceled for reminder: \(reminder.title)")
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound, .badge])
    }
}
