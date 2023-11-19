//
//  FilterNotifications.swift
//  Fishcus
//
//  Created by Vicky Irwanto on 14/11/23.
//

import UIKit

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
           willPresent notification: UNNotification,
           withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .badge, .sound])
    }
}
