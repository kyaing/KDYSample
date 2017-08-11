//
//  AppDelegate.swift
//  KYWebo
//
//  Created by KYCoder on 2017/8/10.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

let kWeiBoAppKey      = "4151174645"
let kWeiBoAppSecret   = "bc1ba90f99316f7437af12c6767270fd"
let kWeiBoRedirectUrl = "https://api.weibo.com/oauth2/default.html"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var wbToken: String          = ""
    var wbCurrentUserID: String  = ""
    var wbRefreshToken: String   = ""
    var wbExpirationDate: Date = Date()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        WeiboSDK.enableDebugMode(true)
        WeiboSDK.registerApp(kWeiBoAppKey)
        
        let homeController = KYHomeController()
        let navigation = UINavigationController(rootViewController: homeController)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return WeiboSDK.handleOpen(url, delegate: self)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return WeiboSDK.handleOpen(url, delegate: self)
    }
}

extension AppDelegate: WeiboSDKDelegate {
    
    func didReceiveWeiboRequest(_ request: WBBaseRequest!) {
        
    }
    
    func didReceiveWeiboResponse(_ response: WBBaseResponse!) {
        if response.isKind(of: WBSendMessageToWeiboRequest.classForCoder()) {
            
            guard let sendResponse = response as? WBSendMessageToWeiboResponse else { return }
            guard let accessToken = sendResponse.authResponse.accessToken else { return }
            guard let userID = sendResponse.authResponse.userID else { return }
            
            wbToken = accessToken
            wbCurrentUserID = userID
            print("token = \(wbToken)")
            print("userId = \(wbCurrentUserID)")
            
        } else if response.isKind(of: WBAuthorizeResponse.classForCoder()) {
            
            guard let authorizeResponse = response as? WBAuthorizeResponse else { return  }
            guard let userID = authorizeResponse.userID else { return  }
            guard let accessToken = authorizeResponse.accessToken else { return }
            guard let expirationDate = authorizeResponse.expirationDate else { return }
            
            wbToken = accessToken
            wbCurrentUserID = userID
            wbRefreshToken = authorizeResponse.refreshToken
            wbExpirationDate = expirationDate
            
            print("token = \(wbToken)")
            print("userId = \(wbCurrentUserID)")
            print("refreshToken = \(wbRefreshToken)")
            print("expirationDate = \(expirationDate)")
            
            // 保存认证信息
            let authData = [
                "AccessTokenKey"    : wbToken,
                "UserIDKey"         : wbCurrentUserID,
                "RefreshTokenKey"   : wbRefreshToken,
                "ExpirationDateKey" : wbExpirationDate
                ] as [String : Any]
            
            UserDefaults.standard.set(authData, forKey: "WeboAuthData")
            UserDefaults.standard.synchronize()
        }
    }
}

