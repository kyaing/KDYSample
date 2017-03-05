//
//  ViewController.swift
//  SlideTabBar
//
//  Created by kaideyi on 2017/2/19.
//  Copyright © 2017年 kaideyi.com. All rights reserved.
//

import UIKit

class ViewController: SlideTabController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "SlideTabBar"
        self.view.backgroundColor = .white
        
        let titles = ["推荐", "热点", "北京", "阳光宽频", "头条号", "社会聚集", "娱乐", "图片", "三生三世桃花开", "喜剧人"]
        for title in titles {
            var controller = UIViewController()
            controller.title = title
            
            if title == "推荐" {
                controller = SubViewController()
                controller.title = title
            }
            
            let red   = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
            let green = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
            let blue  = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
            let colorRandom = UIColor(red:red, green:green, blue:blue , alpha: 1)
            
            controller.view.backgroundColor = colorRandom
            self.addChildViewController(controller)
            
            // for test
            let label = UILabel()
            label.frame = CGRect(x: (controller.view.width-200)/2.0, y: 100, width: 200, height: 100)
            label.text = title
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 20)
            label.textColor = .white
            controller.view.addSubview(label)
        }
    
        /** 
         *  设置Slide类型 (参数过多，待优化！)
         */
        setSlideSytle(.default(.brown, .blue, 16, nil, 40))
        setSlideSytle(.underline(.black, 15, 5, true))
    }
}

