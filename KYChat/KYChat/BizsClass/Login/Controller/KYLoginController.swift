//
//  KYLoginController.swift
//  KYChat
//
//  Created by kaideyi on 2017/9/2.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import MBProgressHUD

class KYLoginController: KYViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 模拟登录延时
        self.perform(#selector(KYLoginController.loginEaseSDK), with: self, afterDelay: 2.0)
    }
    
    func loginEaseSDK() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        EMClient.shared().login(withUsername: "kaideyi", password: "kaideyi") { (emString, emError) in
            
            if let error = emError {
                var codeString = ""
                switch error.code {
                case EMErrorNetworkUnavailable:       codeString = "网络不可用"
                case EMErrorServerNotReachable:       codeString = "服务器未连接"
                case EMErrorUserAuthenticationFailed: codeString = "密码验证错误"
                default:                              codeString = "登录失败"
                }
                print(">>> 环信：\(codeString) <<<")
                
            } else {
                MBProgressHUD.hide(for: self.view, animated: true)
                print(">>> 环信：登录成功 <<<")
                
                EMClient.shared().options.isAutoLogin = true
                
                DispatchQueue.main.async() {
                    self.postNotificationName(kLoginStateChangedNoti, object: NSNumber(value: true))
                }
            }
        }
    }
}

