//
//  ViewController.swift
//  CycleView
//
//  Created by mac on 17/2/24.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CycleView"
        
        let cycleView = CycleScrollView(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: 150))
        cycleView.imgUrlsArray = ["http://www.baidu.com", "http://www.baidu2.com", "http://www.baidu3.com"]
        self.view.addSubview(cycleView)
    }
}

