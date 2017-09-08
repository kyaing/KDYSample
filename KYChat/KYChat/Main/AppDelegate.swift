//
//  AppDelegate.swift
//  KYChat
//
//  Created by KYCoder on 2017/7/31.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainTabbarVC: KYTabBarController?
    
    // MARK: - AppDelegate

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 10, *) { 
            UNUserNotificationCenter.current().delegate = self
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        // 初始化环信Sdk
        setupEaseSDK(application, launchOptions: launchOptions)
        
        return true
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
    }
}

// MARK: - UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {

    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("iOS 10 收到推送消息 - \(notification.request.content.userInfo)")
    }

    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("iOS 10 点击推送消息的回调 - \(response.notification.request.content.userInfo)")
        completionHandler()
    }
}
