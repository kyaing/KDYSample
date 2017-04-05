//
//  AppDelegate.swift
//  Notifications
//
//  Created by mac on 17/4/5.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // MARK: Application
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window?.frame = UIScreen.main.bounds
        window?.backgroundColor = .white
        
        let controller = ViewController()
        let navigation = UINavigationController(rootViewController: controller)
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        registerNotification()
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 将 device token 转化为字符串
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        print("APNs device token: \(deviceTokenString)")
        
        // 再把 device token 发送到自己的服务器，或第三方推送中
        // ...
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
       
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    // MARK: - Notifications
    
    /// 注册通知
    func registerNotification() {
        // 注册本地通知
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (accepted, error) in
            if !accepted {
                print("Notification access denied!")
            } else {
                print("Notification access success!")
            }
        }
        
        // 注册远程通知
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    /// 创建通知
    func scheduleNotification(at date: Date) {
        // 触发机制
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
        
        // 通知内容
        let content = UNMutableNotificationContent()
        content.title = "Tutorial Reminder"
        content.body = "Just a reminder to read your tutorial over at Soapyigu's Swift30Projects!"
        content.sound = UNNotificationSound.default()
        
        // 传入参数
        let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
        
        // 将创建好的通知传入通知中心
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "remindLater" {
            // 十分钟后再次触发
            let newDate = Date(timeInterval: 10, since: Date())
            scheduleNotification(at: newDate)
        }
    }
}

