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
    
    // MARK: -

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 注册系统推送
        setupPushNotifiation()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        // 初始化EaseSDK
        setupEaseSDK(application, launchOptions: launchOptions)
        
        return true
    }
    
    func setupPushNotifiation() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            
            center.requestAuthorization(options: UNAuthorizationOptions.alert) { (granted, error) in
                if granted {
                    print("推送权限点击允许.")
                    center.getNotificationSettings { (settings) in
                        print("Push Settings: \(settings)")
                    }
                    UIApplication.shared.registerForRemoteNotifications()
                    
                } else {
                    print("推送权限点击不允许.")
                }
            }
            
        } else {
            
        }
    }
}

// MARK: - UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("iOS 10 收到推送消息.")
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("iOS 10 点击推送消息的回调.")
    }
}

