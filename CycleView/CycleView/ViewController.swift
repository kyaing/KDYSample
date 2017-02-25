//
//  ViewController.swift
//  CycleView
//
//  Created by mac on 17/2/24.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CycleDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CycleView"
        
        let cycleView = CycleScrollView()
        cycleView.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 160)
        cycleView.delegate = self
        cycleView.imgUrlsArray = [
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488006512229&di=7d4e6398d9e7a585a8cfac8a7600e35c&imgtype=0&src=http%3A%2F%2Fimgs.shougongke.com%2FPublic%2Fdata%2Fhand%2F201606%2F18%2Fstep%2F49%2F1466244759680.jpg",
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488006512228&di=22f28f74a1c2b657265f92bf59e09bb4&imgtype=0&src=http%3A%2F%2Fmmbiz.qpic.cn%2Fmmbiz%2FzGTqWmwC1zfIMNhWC2iaF70tuYic21eGsgf2YjgsuPpY0bEzjfYWfLKeaqBibRR1ELajpPfTmzkIukKe9j4VGiaTrA%2F0%3Fwxfrom%3D5",
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488006512228&di=13d9c9a74865cb6ad2c0f3448e2a0c45&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201311%2F10%2F20131110211903_fjFhf.jpeg",
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488006512227&di=cf1e7caac6b6e4668f73acdfdddca534&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201606%2F20%2F20160620133855_KkJ2L.jpeg"]
        cycleView.isAutoScroll = true
        self.view.addSubview(cycleView)
    }
    
    public func didSelectImageItem() {
        let controller = UIViewController()
        controller.view.backgroundColor = .white
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

