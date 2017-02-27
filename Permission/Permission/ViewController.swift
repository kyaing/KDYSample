//
//  ViewController.swift
//  Permission
//
//  Created by mac on 17/2/24.
//  Copyright © 2017年 kaideyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Permissions"
    }
    
    // MARK: - Permission
    
    @IBAction func requestContacts(_ sender: Any) {
        let status = Permissions.default.statusOfContacts()
        print("status = \(status.description)")
        
        Permissions.default.requestAccessContacts(agree: {
            self.showPermissionAlert(.contacts, success: true)
        }) {
            self.showPermissionAlert(.contacts)
        }
    }
    
    @IBAction func requestPhotos(_ sender: Any) {
        let status = Permissions.default.statusOfPhotos()
        print("status = \(status.description)")
        
        Permissions.default.requestAccessPhotos(agree: { 
            self.showPermissionAlert(.photos, success: true)
        }) { 
            self.showPermissionAlert(.photos)
        }
    }
    
    @IBAction func requestCamera(_ sender: Any) {
        let status = Permissions.default.statusOfCamera()
        print("status = \(status.description)")
        
        Permissions.default.requestAccessCamera(agree: {
            self.showPermissionAlert(.camera, success: true)
        }) {
            self.showPermissionAlert(.camera)
        }
    }
    
    @IBAction func requestLocation(_ sender: Any) {
        
    }
    
    @IBAction func requestNotification(_ sender: Any) {
        
    }
    
    @IBAction func requestVoice(_ sender: Any) {
        
    }
    
    @IBAction func requestCalendar(_ sender: Any) {
        
    }
    
    @IBAction func requestBluetooth(_ sender: Any) {
        
    }
    
    @IBAction func requestHealthKit(_ sender: Any) {
        
    }
}

