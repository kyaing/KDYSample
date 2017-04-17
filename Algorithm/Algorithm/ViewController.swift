//
//  ViewController.swift
//  Algorithm
//
//  Created by kaideyi on 2017/3/17.
//  Copyright © 2017年 kaideyi.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Algorithm"
        self.view.backgroundColor = .white
        
        testCycleReference()
    }
    
    deinit {
        print("销毁")
    }
    
    // MARK:
    
    func testCycleReference() {
        var a = 100
        var b = 100
        print("a = \(String(format: "%p", a))")
        
        typealias addNumClosure = () -> Void
        let closure: addNumClosure = {
            print("block a = \(String(format: "%p", a))")
            print("block: a + b = \(a + b)")
        }
        
        closure()
        
        a = 200
        b = 200
        print("outside: a + b = \(a + b)")
    }
}

