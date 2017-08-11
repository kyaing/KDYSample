//
//  KYHomeController.swift
//  KYWebo
//
//  Created by KYCoder on 2017/8/10.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

/// Webo首页
class KYHomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Webo"
        self.view.backgroundColor = .white
        
        if WeiboSDK.isCanSSOInWeiboApp() && !isAuthorizeExpired() {
            ssoAuthorLogin()  // SSO认证登录
        }
    }
    
    func ssoAuthorLogin() {
        let request = WBAuthorizeRequest.request() as! WBAuthorizeRequest
        request.scope = "all"
        request.redirectURI = kWeiBoRedirectUrl
        request.userInfo = [
            "SSO_From": "KYHomeController",
            "Other_Info_1": NSNumber(value: 123),
            "Other_Info_2": ["obj1", "obj2"],
            "Other_Info_3": ["key1": "obj1", "key2": "obj2"]
        ]
        
        WeiboSDK.send(request)
    }
    
    func isAuthorizeExpired() -> Bool {
        guard let authData = UserDefaults.standard.object(forKey: "WeboAuthData") as? [String: Any] else {
            return false
        }
        
        let expirationDate = authData["ExpirationDateKey"] as! Date
        
        let now = Date()
        return (now.compare(expirationDate) == .orderedAscending)
    }
}

