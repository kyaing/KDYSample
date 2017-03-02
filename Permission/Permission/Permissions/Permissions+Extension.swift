//
//  Permissions+Extension.swift
//  Permission
//
//  Created by kaideyi on 2017/3/1.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

// MARK: -
extension UIViewController {
    
    public func showPermissionAlert(_ style: PermissionType, success agree: Bool = false) {
        
        if agree {
            #if DEBUG
                var message = ""
                switch style {
                case .contacts:         message = "成功访问【通讯录】权限"
                case .photos:           message = "成功访问【照片】权限"
                case .camera:           message = "成功访问【相机】权限"
                case .microphone:       message = "成功访问【麦克风】权限"
                case .location:         message = "成功访问【定位】权限"
                case .event(.calendar): message = "成功访问【日历】权限"
                case .event(.reminder): message = "成功访问【提醒事项】权限"
                case .bluetooth:        message = "成功访问【蓝牙】权限"
                }
                
                let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                let doneAction = UIAlertAction(title: "确定", style: .default, handler: nil)
                alert.addAction(doneAction)
                self.present(alert, animated: true, completion: nil)
            #endif
            
        } else {
            var title = "", message = ""
            switch style {
            case .contacts:          title = "通讯录权限未开启"; message = "进入设置-隐私-通讯录，开启通讯录功能"
            case .photos:            title = "照片权限未开启";   message = "进入设置-隐私-照片，开启照片功能"
            case .camera:            title = "相机权限未开启";   message = "进入设置-隐私-相机，开启相机功能"
            case .microphone:        title = "麦克风权限未开启"; message = "进入设置-隐私-麦克风，开启麦克风功能"
            case .location:          title = "定位权限未开启"; message = "进入设置-隐私-定位，开启定位功能"
            case .event(.calendar):  title = "日历权限未开启"; message = "进入设置-隐私-日历，开启日历功能"
            case .event(.reminder):  title = "提醒事项权限未开启"; message = "进入设置-隐私-提醒事项，开启提醒事项功能"
            case .bluetooth:         title = "蓝牙权限未开启"; message = "进入设置-隐私-蓝牙，开启蓝牙功能"
            }
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "忽略", style: .cancel, handler: { (alertAction) in
                print("忽略设置权限")
            })
            let settingAction = UIAlertAction(title: "设置", style: .destructive, handler: { (alertAction) in
                if let settingUrl = URL(string: UIApplicationOpenSettingsURLString) {
                    if UIApplication.shared.canOpenURL(settingUrl) {
                        UIApplication.shared.openURL(settingUrl)
                    }
                }
            })
            
            alert.addAction(cancelAction)
            alert.addAction(settingAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}

