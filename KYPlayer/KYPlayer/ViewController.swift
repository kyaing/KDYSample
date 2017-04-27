//
//  ViewController.swift
//  KYPlayer
//
//  Created by mac on 17/4/11.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "播放器"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        
        let playerView = KYPlayerView()
        playerView.backgroundColor = .black
        self.view.addSubview(playerView)
    
        playerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.left.right.equalTo(self.view)
            make.height.equalTo(playerView.snp.width).multipliedBy(9.0/16.0)
        }
    }
}

