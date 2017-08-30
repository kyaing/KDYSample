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
        
        
        // 初始化EaseSDK
        EaseSDKHelper.share.hyphenate(withApplication: application,
                                        launchOptions: launchOptions,
                                               appkey: emAppKey,
                                          apnsCerName: emApnsDevCerName,
                                          otherConfig: nil)
        
        self.window?.rootViewController = KYTabBarController()
    }
    
    func loginStateChanged(_ notification: Notification) {
        
    }
}


