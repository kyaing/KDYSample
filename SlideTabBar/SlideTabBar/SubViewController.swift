//
//  SubViewController.swift
//  SlideTabBar
//
//  Created by kaideyi on 2017/2/22.
//  Copyright © 2017年 kaideyi.com. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let titles = ["图片", "三生三世桃花开", "喜剧人"]
        for title in titles {
            let controller = UIViewController()
            controller.title = title
            
            let red   = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
            let green = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
            let blue  = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
            let colorRandom = UIColor(red:red, green:green, blue:blue , alpha: 1)
            
            controller.view.backgroundColor = colorRandom
            self.addChildViewController(controller)
        }
    }
}

