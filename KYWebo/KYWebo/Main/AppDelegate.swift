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
    
    var wbToken: String = ""

    var wbCurrentUserID: String = ""
    
    var wbRefreshToken: String = ""

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
            
            if let sendResponse = response as? WBSendMessageToWeiboResponse {
                let accessToken = sendResponse.authResponse.accessToken
                let userID = sendResponse.authResponse.userID
                
                if let token = accessToken, let ID = userID {
                    wbToken = token
                    wbCurrentUserID = ID
                    
                    print("token = \(wbToken)\n userId = \(wbCurrentUserID)\n")
                }
            }
            
        } else if response.isKind(of: WBAuthorizeResponse.classForCoder()) {
            
            if let authorizeResponse = response as? WBAuthorizeResponse {
                wbToken = authorizeResponse.accessToken
                wbCurrentUserID = authorizeResponse.userID
                wbRefreshToken = authorizeResponse.refreshToken
                
                print("token = \(wbToken)\n userId = \(wbCurrentUserID)\n refreshToken = \(wbRefreshToken)")
            }
        }
    }
}

