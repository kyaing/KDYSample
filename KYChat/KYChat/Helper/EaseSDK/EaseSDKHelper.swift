//
//  EaseSDKHelper.swift
//  KYChat
//
//  Created by KYCoder on 2017/8/30.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class EaseSDKHelper: NSObject {
    
    static let share = EaseSDKHelper()
    private override init() {}
    
    func hyphenate(withApplication application: UIApplication,
                                 launchOptions: [AnyHashable: Any]?,
                                        appkey: String,
                                   apnsCerName: String,
                                   otherConfig: [AnyHashable: Any]?) {
        
        // 配置SDK
        let options = EMOptions(appkey: appkey)
        options?.apnsCertName = apnsCerName
        options?.isAutoAcceptGroupInvitation = false
        options?.enableConsoleLog = true
        
        EMClient.shared().initializeSDK(with: options)
        
        setupAppDelegateNotifiction()
        registerRemoteNotification()
    }
    
    func setupAppDelegateNotifiction() {
        
    }
    
    func registerRemoteNotification() {
        
    }
}

