//
//  AppDelegate.swift
//  KYPlayer
//
//  Created by mac on 17/4/11.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
     
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        window?.rootViewController = KYPlayerViewController()
        window?.makeKeyAndVisible()
        
        testGCDGroup()
        
        return true
    }
    
    func testGCDGroup() {
        /** 
         *  怎么解决多线程的异步依赖问题？这是一个经典的问题，
         *  能最先想到的是GCD组，但怎么保证顺序问题，参考：http://www.jianshu.com/p/480d0c64d63c
         */
        
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async { 
            print("线程一");
            group.leave()
        }
        
        group.enter()
        DispatchQueue.global().async { 
            print("线程二");
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) { 
            print("主线程");
        }
        
        print(ViewController())
    }
}

