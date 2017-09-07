//
//  AppDelegate+EaseSDK.swift
//  KYChat
//
//  Created by KYCoder on 2017/8/30.
//  Copyright © 2017年 mac. All rights reserved.
//

import Foundation

extension AppDelegate {
    
    func setupEaseSDK(_ application: UIApplication, launchOptions: [AnyHashable: Any]?) {
        
        // 判断登录状态
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.loginStateChanged(_:)),
                                               name: NSNotification.Name(rawValue: kLoginStateChangedNoti),
                                               object: nil)
        
        // 初始化EaseSDK
        EaseSDKHelper.share.hyphenate(withApplication: application,
                                        launchOptions: launchOptions,
                                               appkey: emAppKey,
                                          apnsCerName: emApnsDevCerName,
                                          otherConfig: nil)
        
        // 判断是否登录成功
        if EMClient.shared().isAutoLogin {
            NotificationCenter.default.post(name: Notification.Name(rawValue: kLoginStateChangedNoti), object: NSNumber(value: true))
            
        } else {
            NotificationCenter.default.post(name: Notification.Name(rawValue: kLoginStateChangedNoti), object: NSNumber(value: false))
        }
    }
    
    func loginStateChanged(_ notification: Notification) {
        if let loginState = (notification.object as AnyObject).boolValue {

            if loginState == true {
                if mainTabbarVC == nil {
                    mainTabbarVC = KYTabBarController()
                }
                
                KYChatHelper.share.asyncPushOptions()
                KYChatHelper.share.asyncConversationFromDB()
                KYChatHelper.share.mainTabbarVC = mainTabbarVC
                
                self.window?.rootViewController = self.mainTabbarVC
                
            } else {
                if let tabbarController = mainTabbarVC {
                    _ = tabbarController.navigationController?.popToRootViewController(animated: false)
                }
                
                let loginVC = KYLoginViewController()
                let navigation = KYNavigationController(rootViewController: loginVC)
                
                self.window?.rootViewController = navigation
            }
        }
    }
    
    // MARK: -
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // 进入前台，重连SDK
        EMClient.shared().applicationWillEnterForeground(application)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // 进入后台，断开SDK
        EMClient.shared().applicationDidEnterBackground(application)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 注册远程通知成功，交给SDK并绑定
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            EMClient.shared().bindDeviceToken(deviceToken)
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // 注册远程通知失败，若有失败看看环境配置或证书是否有误
        print("APN error: %@", error.localizedDescription)
    }
}


