//
//  ViewController.swift
//  Algorithm
//
//  Created by kaideyi on 2017/3/17.
//  Copyright © 2017年 kaideyi.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Algorithm"
        self.view.backgroundColor = .white

        button.frame = CGRect(x: 100, y: 100, width: 150, height: 30)
        button.backgroundColor = .gray
        button.center.x = self.view.center.x
        button.setTitle("点我观察背景色", for: .normal)
        button.addTarget(self, action: #selector(clickButtonAction), for: .touchUpInside)
        self.view.addSubview(button)
        
        button.addObserver(self, forKeyPath: "backgroundColor", options: .new, context: nil)
        
        testCycleReference()
    }
    
    deinit {
        print("销毁")
        button.backgroundColor?.removeObserver(self, forKeyPath: "backgroundColor", context: nil)
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
    
    func clickButtonAction() {
        let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        let green = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        
        button.backgroundColor = UIColor(colorLiteralRed: Float(red), green: Float(green), blue: Float(blue), alpha: 1)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let newValue = change?[.newKey] {
            print("Value Changed: \(newValue)")
        }
    }
}

