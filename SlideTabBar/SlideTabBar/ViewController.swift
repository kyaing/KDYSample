//
//  ViewController.swift
//  SlideTabBar
//
//  Created by kaideyi on 2017/2/19.
//  Copyright © 2017年 kaideyi.com. All rights reserved.
//

import UIKit

class ViewController: SlideViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "SlideTabBar"
        self.view.backgroundColor = .white
        
        let titles = ["推荐", "热点", "北京", "阳光宽频", "头条号", "社会聚集", "娱乐", "图片"]
        for title in titles {
            let controller = UIViewController()
            controller.title = title
            
            let red   = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
            let green = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
            let blue  = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
            let colorRundom = UIColor(red:red, green:green, blue:blue , alpha: 1)
            
            controller.view.backgroundColor = colorRundom
            self.addChildViewController(controller)
        }
    }
}

