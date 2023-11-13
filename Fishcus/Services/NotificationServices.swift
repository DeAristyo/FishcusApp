//
//  NotificationServices.swift
//  Fishcus
//
//  Created by Vicky Irwanto on 13/11/23.
//

import UIKit
import UserNotifications


class NotificationServices{
    
    private func startNotification(){
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "App in background"
        content.body = "You've entered the pause screen"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "AppEnteredBackground", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if error != nil {
                // Handle any errors.
                print(error ?? "")
            }
        }
    }
    
    func pushNotification(){
        self.startNotification()
    }
}
