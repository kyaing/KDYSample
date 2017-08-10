//
//  AppDelegate.swift
//  Algorithm
//
//  Created by kaideyi on 2017/3/17.
//  Copyright © 2017年 kaideyi.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
    
        let navigation = UINavigationController(rootViewController: ViewController())
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        return true
    }
}

