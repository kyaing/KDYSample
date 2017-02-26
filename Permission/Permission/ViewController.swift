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
        let stautus = Permissions.default.statusOfContacts()
        print("\(stautus.description)")
    }
    
    @IBAction func requestPhotos(_ sender: Any) {
        
    }
    
    @IBAction func requestCamera(_ sender: Any) {
        
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

