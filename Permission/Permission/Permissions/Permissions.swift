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
import UserNotifications
import CoreLocation
import EventKit
import CoreBluetooth

public enum PermissionType: CustomStringConvertible {
    
    public enum LocationUsage {
        case always
        case whenInUsage
    }
    
    public enum EventType {
        case calendar
        case reminder
    }
    
    case contacts
    case photos
    case camera
    case microphone
    case notification
    case location(LocationUsage)
    case event(EventType)
    case bluetooth
    
    public var description: String {
        switch self {
        case .contacts:     return "Contacts"
        case .photos:       return "Photos"
        case .camera:       return "Camera"
        case .microphone:   return "Microphone"
        case .notification: return "NOtification"
        case .location:     return "Location"
        case .event:        return "Event"
        case .bluetooth:    return "Bluetooth"
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
    
    public var agreeColsure: AccessColsure!
    
    public var deniedColsure: AccessColsure!
    
    open func requestPermission(_ type: PermissionType, agree agreeColsure: @escaping AccessColsure,
                                 denied deniedColsure: @escaping AccessColsure) {
        
        switch type {
        case .contacts:            requestContacts(agree: agreeColsure, denied: deniedColsure)
        case .photos:              requestPhotos(agree: agreeColsure, denied: deniedColsure)
        case .camera:              requestCamera(agree: agreeColsure, denied: deniedColsure)
        case .microphone:          requestMicophone(agree: agreeColsure, denied: deniedColsure)
        case .notification:        requestNotification(agree: agreeColsure, denied: deniedColsure)
        case .location(let usage): requestLocation(usage, agree: agreeColsure, denied: deniedColsure)
        case .event(let event):    requestEvent(event, agree: agreeColsure, denied: deniedColsure)
        case .bluetooth:           requestBluetooth(agree: agreeColsure, denied: deniedColsure)
        }
    }
    
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
    
    func requestContacts(agree agreeColsure: @escaping AccessColsure,
                               denied deniedColsure: @escaping AccessColsure) {
        
        let contactStatus = statusOfContacts()
        switch contactStatus {
        case .authorized:  agreeColsure()
        case .notDetermined:
            if #available(iOS 9.0, *) {
                let contactStore = CNContactStore()
                contactStore.requestAccess(for: .contacts) { (granted, error) in
                    granted == true ? agreeColsure() : deniedColsure()
                }
            } else {
               
            }
        case .denied:  deniedColsure()
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
    
    func requestPhotos(agree agreeColsure: @escaping AccessColsure,
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
    
    func requestCamera(agree agreeColsure: @escaping AccessColsure,
                             denied deniedColsure: @escaping AccessColsure) {
        
        let cameraStatus = statusOfCamera()
        switch cameraStatus {
        case .authorized:  agreeColsure()
        case .notDetermined:
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) { (granted) in
                granted == true ? agreeColsure() : deniedColsure()
            }
        case .denied:  deniedColsure()
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
    
    func requestMicophone(agree agreeColsure: @escaping AccessColsure,
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
    
    // MARK: Notification
    func statusOfNotification() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.getNotificationSettings { (settings) in
                print("settings = \(settings)")
            }
            
        } else {
            
        }
    }
    
    func requestNotification(agree agreeColsure: @escaping AccessColsure,
                          denied deniedColsure: @escaping AccessColsure) {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            let options = UNAuthorizationOptions.alert.rawValue | UNAuthorizationOptions.badge.rawValue | UNAuthorizationOptions.sound.rawValue
            center.requestAuthorization(options: UNAuthorizationOptions(rawValue: options)) { (granted, error) in
                granted == true ? agreeColsure() : deniedColsure()
            }
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
    
    func requestLocation(_ usage: PermissionType.LocationUsage, agree agreeColsure: @escaping AccessColsure,
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
                self.agreeColsure = agreeColsure
                self.deniedColsure = deniedColsure
                
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
    
    // MARK: EventKit
    func statusOfEventKit(_ eventType: PermissionType.EventType) -> PermissionStatus {
        if eventType == .calendar {
            let status = EKEventStore.authorizationStatus(for: .event)
            switch status {
            case .authorized:           return .authorized
            case .notDetermined:        return .notDetermined
            case .denied, .restricted:  return .denied
            }
        } else {
            let status = EKEventStore.authorizationStatus(for: .reminder)
            switch status {
            case .authorized:           return .authorized
            case .notDetermined:        return .notDetermined
            case .denied, .restricted:  return .denied
            }
        }
    }
    
    func requestEvent(_ eventType: PermissionType.EventType, agree agreeColsure: @escaping AccessColsure,
                            denied deniedColsure: @escaping AccessColsure) {
        let status = statusOfEventKit(eventType)
        switch status {
        case .authorized:   agreeColsure()
        case .notDetermined:
            var type = EKEntityType.event
            if eventType == .reminder { type = .reminder }
            EKEventStore().requestAccess(to: type) { (granted, error) in
                granted == true ? agreeColsure() : deniedColsure()
            }
            
        case .denied: deniedColsure()
        }
    }
    
    // MARK: Bluetooth
    func statusOfBluetooth() -> PermissionStatus {
        let status = CBPeripheralManager.authorizationStatus()
        switch status {
        case .authorized:           return .authorized
        case .notDetermined:        return .notDetermined
        case .denied, .restricted:  return .denied
        }
    }
    
    func requestBluetooth(agree agreeColsure: @escaping AccessColsure,
                                denied deniedColsure: @escaping AccessColsure) {
        let status = statusOfBluetooth()
        switch status {
        case .authorized:   agreeColsure()
        case .notDetermined:  CBPeripheralManager().startAdvertising(nil)
        case .denied:   deniedColsure()
        }
    }
}

// MARK: -
extension Permissions: CLLocationManagerDelegate {
    // 定位权限发生改变
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways: locationUsage == .always ? agreeColsure() : deniedColsure()
        case .authorizedWhenInUse:  locationUsage == .whenInUsage ? agreeColsure() : deniedColsure()
        case .denied: deniedColsure()
        default: break
        }
    }
}
  
