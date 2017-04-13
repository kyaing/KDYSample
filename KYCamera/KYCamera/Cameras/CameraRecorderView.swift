//
//  CameraRecorderView.swift
//  KYCamera
//
//  Created by mac on 17/4/12.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

/// 相机拍摄视图
class CameraRecorderView: UIView {
    
    // MARK: - Properites
    
    lazy var cameraButton: UIButton = {
        let cameraBtn = UIButton()
        cameraBtn.setTitle("拍照", for: .normal)
        cameraBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        cameraBtn.addTarget(self, action: #selector(takePhotoAction), for: .touchUpInside)
        
        return cameraBtn
    }()
    
    lazy var photosButton: UIButton = {
        let photoBtn = UIButton()
        photoBtn.backgroundColor = .red
        photoBtn.imageView?.contentMode = .scaleAspectFill
        
        return photoBtn
    }()
    
    var takePhotoClosure: () -> Void = {}
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(cameraButton)
        self.addSubview(photosButton)
        
        cameraButton.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
        
        photosButton.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
    }
    
    func takePhotoAction() {
        takePhotoClosure()
    }
    
    func reload(_ image: UIImage) {
        photosButton.setImage(image, for: .normal)
    }
}

