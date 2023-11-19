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
        content.title = "🐟 The fish are waiting!"
        content.body = "Remember to come back or you will miss out on rare fish! 🐟"
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
