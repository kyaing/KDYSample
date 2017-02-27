//
//  Permissions.swift
//  Permission
//
//  Created by kaideyi on 2017/2/25.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import Contacts
import AddressBook
import Photos

public enum PermissionType: CustomStringConvertible {
    case contacts
    case photos
    case camera
    
    public var description: String {
        switch self {
        case .contacts: return "Contacts"
        case .photos:   return "Photos"
        case .camera:   return "Camera"
        }
    }
}

public enum PermissionStatus: Int, CustomStringConvertible {
    case authorized     // 已授权
    case notDetermined  // 未弹出授权
    case denied         // 拒绝授权

    public var description: String {
        switch self {
        case .authorized:    return "Authorized"
        case .notDetermined: return "NotDetermined"
        case .denied:        return "Denied"
        }
    }
}

// MARK: -

/// 权限管理
public class Permissions: NSObject {
    
    // MARK: Proproties
    
    static let `default` = Permissions()
    private override init() {}
    
    public typealias AccessColsure = () -> Void
    
    // MARK: Contacts
    
    func statusOfContacts() -> PermissionStatus {
        if #available(iOS 9.0, *) {
            let contactStatus = CNContactStore.authorizationStatus(for: .contacts)
            switch contactStatus {
            case .authorized:
                return .authorized
            case .notDetermined:
                return .notDetermined
            case .denied, .restricted:
                return .denied
            }
        } else {
            let contactStatus = ABAddressBookGetAuthorizationStatus()
            switch contactStatus {
            case .authorized:
                return .authorized
            case .notDetermined:
                return .notDetermined
            case .denied, .restricted:
                return .denied
            }
        }
    }
    
    func requestAccessContacts(agree agreeColsure: @escaping AccessColsure,
                               denied deniedColsure: @escaping AccessColsure) {
        
        let contactStatus = statusOfContacts()
        switch contactStatus {
        case .authorized:
            agreeColsure()
            
        case .notDetermined:
            if #available(iOS 9.0, *) {
                let contactStore = CNContactStore()
                contactStore.requestAccess(for: .contacts, completionHandler: { (granted, error) in
                    if granted {
                        agreeColsure()
                    } else {
                        deniedColsure()
                    }
                })
            } else {
               
            }
        
        case .denied:
            deniedColsure()
        }
    }
    
    // MARK: Photos
    func statusOfPhotos() -> PermissionStatus {
        return .authorized
    }
    
    func requestAccessPhotos(agree agreeColsure: @escaping AccessColsure,
                             denied deniedColsure: @escaping AccessColsure) {
        
    }
}

// MARK: -
extension UIViewController {
    
    public func showPermissionAlert(_ style: PermissionType, success agree: Bool = false) {
        
        if agree {
            var message = ""
            switch style {
            case .contacts:  message = "成功访问通讯录权限"
            case .photos:    message = "成功访问照片权限"
            case .camera:    message = "成功访问相机权限"
            }
            
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let doneAction = UIAlertAction(title: "确定", style: .default, handler: nil)
            alert.addAction(doneAction)
            self.present(alert, animated: true, completion: nil)
            
        } else {
            var title = "", message = ""
            switch style {
            case .contacts:  title = "通讯录权限未开启"; message = "进入设置-隐私-通讯录，开启通讯录功能"
            case .photos:    title = "照片权限未开启";   message = "进入设置-隐私-照片，开启照片功能"
            case .camera:    title = "相机权限未开启";   message = "进入设置-隐私-相机，开启相机功能"
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

// MARK: -
public class ContactsManager: NSObject {
    
    //
    public func getContacts() -> String {
        return ""
    }
}

// MARK: - 
public class LocationManager: NSObject {
    
    //
    public func getLocations() -> (Float, Float) {
        return (2.0, 3.0)
    }
}
  
