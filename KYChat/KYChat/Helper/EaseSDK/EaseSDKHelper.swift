//
//  EaseSDKHelper.swift
//  KYChat
//
//  Created by KYCoder on 2017/8/30.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import UserNotifications

class EaseSDKHelper: NSObject {
    
    static let share = EaseSDKHelper()
    private override init() {}
    
    // MARK: -
    
    func hyphenate(withApplication application: UIApplication,
                                 launchOptions: [AnyHashable: Any]?,
                                        appkey: String,
                                   apnsCerName: String,
                                   otherConfig: [AnyHashable: Any]?) {
        
        let options = EMOptions(appkey: appkey)
        options?.apnsCertName = apnsCerName
        options?.isAutoAcceptGroupInvitation = false
        options?.enableConsoleLog = true
        
        EMClient.shared().initializeSDK(with: options)
        
        setupAppDelegateNotifiction()
        registerRemoteNotification()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: -
    
    func setupAppDelegateNotifiction() {
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackgroundNotif(_:)), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForegroundNotif(_:)), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    func appDidEnterBackgroundNotif(_ notification: Notification) {
        EMClient.shared().applicationDidEnterBackground(notification.object)
    }
    
    func appWillEnterForegroundNotif(_ notification: Notification) {
        EMClient.shared().applicationWillEnterForeground(notification.object)
    }
    
    func registerRemoteNotification() {
        let application = UIApplication.shared
        application.applicationIconBadgeNumber = 0
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: UNAuthorizationOptions(rawValue: UNAuthorizationOptions.alert.rawValue | UNAuthorizationOptions.sound.rawValue | UNAuthorizationOptions.badge.rawValue)) { (granted, error) in
                if granted {
                    print("推送权限点击允许.")
                    center.getNotificationSettings { (settings) in
                        print("Push Settings: \(settings)")
                    }

                } else {
                    print("推送权限点击不允许.")
                }
            }
            
        } else {
            application.registerUserNotificationSettings(UIUserNotificationSettings(types: UIUserNotificationType(rawValue: UIUserNotificationType.alert.rawValue | UIUserNotificationType.sound.rawValue | UIUserNotificationType.badge.rawValue), categories: nil))
        }
        
        application.registerForRemoteNotifications()
    }
}

