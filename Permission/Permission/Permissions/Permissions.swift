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
    
    private var locationManager: CLLocationManager!
    
    public var locationUsage: PermissionType.LocationUsage!
    
    public typealias AccessColsure = () -> Void
    
    public var _agreeColsure: AccessColsure!
    
    public var _deniedColsure: AccessColsure!
    
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
    
    func requestAccessLocation(_ usage: PermissionType.LocationUsage, agree agreeColsure: @escaping AccessColsure,
                               denied deniedColsure: @escaping AccessColsure) {
        
        let status = statusOfLocation()
        switch status {
        case .authorized: agreeColsure()
        case .notDetermined:
            if CLLocationManager.locationServicesEnabled() {
                // 设置为属性，否则定位权限提示框会闪现
                locationManager = CLLocationManager()
                locationManager.delegate = self
                locationUsage = usage
                _agreeColsure = agreeColsure
                _deniedColsure = deniedColsure
                
                switch usage {
                case .always:       locationManager.requestAlwaysAuthorization()
                case .whenInUsage:  locationManager.requestWhenInUseAuthorization()
                }
                locationManager.startUpdatingLocation()
                
            } else {
                deniedColsure()
            }
        case .denied: deniedColsure()
        }
    }
}

extension Permissions: CLLocationManagerDelegate {
    // 定位权限发生改变
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways: locationUsage == .always ? _agreeColsure() : _deniedColsure()
        case .authorizedWhenInUse:  locationUsage == .whenInUsage ? _agreeColsure() : _deniedColsure()
        case .denied: _deniedColsure()
        default: break
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
  
