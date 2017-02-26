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
    
    ///fdasfgs
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
    
    func requestAccessContacts(_ type: PermissionType, agree agreeColsure: AccessColsure, denied deniedColsure: AccessColsure) {
        
        let status = statusOfContacts()
        if #available(iOS 9.0, *) {
            switch status {
            case .authorized: break
            case .notDetermined: break
            case .denied: break
            }
        } else {
            
        }
    }
    
    // MARK: Photos
    func statusOfPhotos() -> PermissionStatus {
        return .authorized
    }
    
    func requestAccessPhotos(_ type: PermissionType, agree agreeColsure: AccessColsure, denied deniedColsure: AccessColsure) {
        
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

  
