//
//  ViewController.swift
//  Notifications
//
//  Created by mac on 17/4/5.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    var content = UNMutableNotificationContent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Notifications"
        self.view.backgroundColor = .white
        
        scheduleNotification()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func scheduleNotification() {
        // 创建通知内容
        content.title = "Notificatin Center"
        content.body = "Local Notification Test"
        content.sound = UNNotificationSound.default()
        
        // 通知触发时机
        let triger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: true)
        let request = UNNotificationRequest(identifier: "request", content: content, trigger: triger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("We had an error: \(error)")
            }
        }
    }
    
    func scheduleActionNotification() {
        // 添加相应的交互
        let action1 = UNTextInputNotificationAction(identifier: "text", title: "文字回复", options: [])
        let action2 = UNNotificationAction(identifier: "remind", title: "稍后提醒", options: .foreground)
        let action3 = UNNotificationAction(identifier: "cacel", title: "取消", options: .destructive)
        let category = UNNotificationCategory(identifier: "Normal", actions: [action1, action2, action3], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        scheduleNotification()
    }
    
    func scheduleImageNotification() {
        // 添加图片附件（图片上限10M）
        let imageString = Bundle.main.path(forResource: "test", ofType: "png")
        do {
            let imageAttachment = try UNNotificationAttachment(identifier: "imageAttachment", url: URL(fileURLWithPath: imageString!), options: nil)
            content.attachments = [imageAttachment]
            
        } catch {
            print("error")
        }

        scheduleNotification()
    }
}

extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let content = response.notification.request.content
        print("推送接受的内容 = \(content)")
        
        if  {
            <#code#>
        }
    }
}

