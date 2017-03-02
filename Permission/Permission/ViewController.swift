//
//  ViewController.swift
//  Permission
//
//  Created by mac on 17/2/24.
//  Copyright © 2017年 kaideyi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Permissions"
    }
    
    // MARK: - Permission
    
    @IBAction func requestContacts(_ sender: Any) {
        Permissions.default.requestAccessContacts(agree: {
            self.showPermissionAlert(.contacts, success: true)
        }) {
            self.showPermissionAlert(.contacts)
        }
    }
    
    @IBAction func requestPhotos(_ sender: Any) {
        Permissions.default.requestAccessPhotos(agree: { 
            self.showPermissionAlert(.photos, success: true)
        }) { 
            self.showPermissionAlert(.photos)
        }
    }
    
    @IBAction func requestCamera(_ sender: Any) {
        Permissions.default.requestAccessCamera(agree: {
            self.showPermissionAlert(.camera, success: true)
        }) {
            self.showPermissionAlert(.camera)
        }
    }
    
    @IBAction func requestLocation(_ sender: Any) {
        Permissions.default.requestAccessLocation(.whenInUsage, agree: {
            self.showPermissionAlert(.location(.whenInUsage), success: true)
        }) { 
            self.showPermissionAlert(.location(.whenInUsage))
        }
    }
    
    @IBAction func requestNotification(_ sender: Any) {
        
    }
    
    @IBAction func requestVoice(_ sender: Any) {
        Permissions.default.requestAccessMicophone(agree: { 
            self.showPermissionAlert(.microphone, success: true)
        }) { 
            self.showPermissionAlert(.microphone)
        }
    }
    
    @IBAction func requestCalendar(_ sender: Any) {
        Permissions.default.requestAccessEvent(.calendar, agree: { 
            self.showPermissionAlert(.event(.calendar), success: true)
        }) { 
            self.showPermissionAlert(.event(.calendar))
        }
    }
    
    @IBAction func requestReminder(_ sender: Any) {
        Permissions.default.requestAccessEvent(.reminder, agree: {
            self.showPermissionAlert(.event(.reminder), success: true)
        }) {
            self.showPermissionAlert(.event(.reminder))
        }
    }
    
    @IBAction func requestBluetooth(_ sender: Any) {
        Permissions.default.requestAccessBluetooth(agree: { 
            self.showPermissionAlert(.bluetooth, success: true)
        }) { 
            self.showPermissionAlert(.bluetooth)
        }
    }
}

