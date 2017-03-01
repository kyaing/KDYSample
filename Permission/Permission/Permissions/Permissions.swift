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
import AssetsLibrary
import AVFoundation
import CoreLocation

public enum PermissionType: CustomStringConvertible {
    
    public enum LocationUsage {
        case always
        case whenInUsage
    }
    
    case contacts
    case photos
    case camera
    case microphone
    case location(LocationUsage)
    
    public var description: String {
        switch self {
        case .contacts:     return "Contacts"
        case .photos:       return "Photos"
        case .camera:       return "Camera"
        case .microphone:   return "Microphone"
        case .location:     return "Location"
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
            let status = CNContactStore.authorizationStatus(for: .contacts)
            switch status {
            case .authorized:           return .authorized
            case .notDetermined:        return .notDetermined
            case .denied, .restricted:  return .denied
            }
        } else {
            let status = ABAddressBookGetAuthorizationStatus()
            switch status {
            case .authorized:           return .authorized
            case .notDetermined:        return .notDetermined
            case .denied, .restricted:  return .denied
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
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:           return .authorized
        case .notDetermined:        return .notDetermined
        case .denied, .restricted:  return .denied
        }
    }
    
    func requestAccessPhotos(agree agreeColsure: @escaping AccessColsure,
                             denied deniedColsure: @escaping AccessColsure) {
        
        let photoStatus = statusOfPhotos()
        switch photoStatus {
        case .authorized:  agreeColsure()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:  agreeColsure()
                default: deniedColsure()
                }
            }
            
        case .denied: deniedColsure()
        }
    }
    
    // MARK: Camera
    func statusOfCamera() -> PermissionStatus {
        let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        switch status {
        case .authorized:           return .authorized
        case .notDetermined:        return .notDetermined
        case .denied, .restricted:  return .denied
        }
    }
    
    func requestAccessCamera(agree agreeColsure: @escaping AccessColsure,
                             denied deniedColsure: @escaping AccessColsure) {
        
        let cameraStatus = statusOfCamera()
        switch cameraStatus {
        case .authorized:  agreeColsure()
        case .notDetermined:
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) { (granted) in
                granted == true ? agreeColsure() : deniedColsure()
            }
        case .denied: deniedColsure()
        }
    }
    
    // MARK: Microphone
    func statusOfMicophone() -> PermissionStatus {
        let status = AVAudioSession.sharedInstance().recordPermission()

        switch status {
        case AVAudioSessionRecordPermission.granted:      return .authorized
        case AVAudioSessionRecordPermission.undetermined: return .notDetermined
        case AVAudioSessionRecordPermission.denied:       return .denied
        default: return .denied
        }
    }
    
    func requestAccessMicophone(agree agreeColsure: @escaping AccessColsure,
                                denied deniedColsure: @escaping AccessColsure) {
        let status = statusOfMicophone()
        switch status {
        case .authorized:  agreeColsure()
        case .notDetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                granted == true ? agreeColsure() : deniedColsure()
            }
        case .denied: deniedColsure()
        }
    }
    
    // MARK: Location
    func statusOfLocation() -> PermissionStatus {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways:     return .authorized
        case .authorizedWhenInUse:  return .authorized
        case .notDetermined:        return .notDetermined
        case .denied, .restricted:  return .denied
        }
    }
    
    func requestAccessLocation(_ useage: PermissionType.LocationUsage, agree agreeColsure: @escaping AccessColsure,
                               denied deniedColsure: @escaping AccessColsure) {
        let status = statusOfLocation()
        switch status {
        case .authorized:
            if useage == .always {
                
            } else if useage == .whenInUsage {
                
            }
        case .notDetermined:
            if CLLocationManager.locationServicesEnabled() {
                
            } else {
                deniedColsure()
            }
        case .denied: deniedColsure()
        }
    }
}

// MARK: -
extension UIViewController {
    
    public func showPermissionAlert(_ style: PermissionType, success agree: Bool = false) {
        
        if agree {
            #if DEBUG
                var message = ""
                switch style {
                case .contacts:     message = "成功访问【通讯录】权限"
                case .photos:       message = "成功访问【照片】权限"
                case .camera:       message = "成功访问【相机】权限"
                case .microphone:   message = "成功访问【麦克风】权限"
                case .location:     message = "成功访问【定位】权限"
                }
                
                let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                let doneAction = UIAlertAction(title: "确定", style: .default, handler: nil)
                alert.addAction(doneAction)
                self.present(alert, animated: true, completion: nil)
            #endif
            
        } else {
            var title = "", message = ""
            switch style {
            case .contacts:     title = "通讯录权限未开启"; message = "进入设置-隐私-通讯录，开启通讯录功能"
            case .photos:       title = "照片权限未开启";   message = "进入设置-隐私-照片，开启照片功能"
            case .camera:       title = "相机权限未开启";   message = "进入设置-隐私-相机，开启相机功能"
            case .microphone:   title = "麦克风权限未开启"; message = "进入设置-隐私-麦克风，开启麦克风功能"
            case .location:     title = "定位权限未开启"; message = "进入设置-隐私-定位，开启定位功能"
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
    
    public func getContacts() -> String {
        return ""
    }
}

// MARK: - 
public class LocationManager: NSObject {

    public func getLocations() -> (Float, Float) {
        return (2.0, 3.0)
    }
}
  
