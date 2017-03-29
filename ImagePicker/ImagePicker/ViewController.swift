//
//  ViewController.swift
//  ImagePicker
//
//  Created by mac on 17/3/28.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ImagePicker"
        self.view.backgroundColor = .white
        
        let photoBtn = UIButton()
        photoBtn.setTitle("选择图片", for: .normal)
        photoBtn.setTitleColor(.red, for: .normal)
        self.view.addSubview(photoBtn)
        
        photoBtn.addTarget(self, action: #selector(ViewController.selectPhotos), for: .touchUpInside)
        
        photoBtn.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.size.equalTo(CGSize(width: 150, height: 40))
        }
    }
    
    func selectPhotos() {
        print("selectPhotos")
    }
}

