//
//  ViewController.swift
//  KYCamera
//
//  Created by mac on 17/4/11.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMedia

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "相机"
        self.view.backgroundColor = .white
        
        let cameraBtn = UIButton()
        cameraBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        cameraBtn.center = self.view.center
        cameraBtn.setTitle("进入相机", for: .normal)
        cameraBtn.setTitleColor(UIColor.red, for: .normal)
        cameraBtn.addTarget(self, action: #selector(ViewController.pushCameraAction), for: .touchUpInside)
        self.view.addSubview(cameraBtn)
    }
    
    func pushCameraAction() {
        self.navigationController?.pushViewController(KYCameraViewController(), animated: true)
    }
}

