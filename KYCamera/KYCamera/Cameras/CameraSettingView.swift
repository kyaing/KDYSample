//
//  CameraSettingView.swift
//  KYCamera
//
//  Created by mac on 17/4/12.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

/// 相机设置视图
class CameraSettingView: UIView {
    
    // MARK: - Properites
    
    /// 返回按钮
    lazy var backButton: UIButton = {
        let backBtn = UIButton()
        backBtn.setTitle("返回", for: .normal)
        backBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        backBtn.setTitleColor(.black, for: .normal)
        backBtn.layer.cornerRadius = 3.0
        backBtn.layer.masksToBounds = true
        backBtn.layer.borderColor = UIColor.black.cgColor
        backBtn.layer.borderWidth = 0.5
        backBtn.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
        
        return backBtn
    }()
    
    /// 切换相机按钮
    lazy var swtichButton: UIButton = {
        let switchbtn = UIButton()
        switchbtn.setTitle("切换", for: .normal)
        switchbtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        switchbtn.setTitleColor(.black, for: .normal)
        switchbtn.layer.cornerRadius = 3.0
        switchbtn.layer.masksToBounds = true
        switchbtn.layer.borderColor = UIColor.black.cgColor
        switchbtn.layer.borderWidth = 0.5
        switchbtn.isSelected = false
        switchbtn.addTarget(self, action: #selector(switchBtnAction(_:)), for: .touchUpInside)
        
        return switchbtn
    }()
    
    /// 闪光灯按钮
    lazy var flashButton: UIButton = {
        let flashBtn = UIButton()
        flashBtn.setTitle("闪光", for: .normal)
        flashBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        flashBtn.setTitleColor(.black, for: .normal)
        flashBtn.layer.cornerRadius = 3.0
        flashBtn.layer.masksToBounds = true
        flashBtn.layer.borderColor = UIColor.black.cgColor
        flashBtn.layer.borderWidth = 0.5
        flashBtn.isSelected = false
        flashBtn.addTarget(self, action: #selector(flashBtnAction(_:)), for: .touchUpInside)
        
        return flashBtn
    }()
    
    var backClosure: () -> Void = {}
    
    var switchClosure: (Bool) -> Void = {_ in }
    
    var flashColsure: (Bool) -> Void = {_ in }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    func setupViews() {
        self.addSubview(backButton)
        self.addSubview(swtichButton)
        self.addSubview(flashButton)
        
        backButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.size.equalTo(CGSize(width: 45, height: 22))
        }
        
        swtichButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-10)
            make.size.equalTo(CGSize(width: 45, height: 22))
        }
        
        flashButton.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.size.equalTo(CGSize(width: 45, height: 22))
        }
    }
    
    func backBtnAction() {
        backClosure()
    }
    
    func switchBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switchClosure(!sender.isSelected)
    }
    
    func flashBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        flashColsure(!sender.isSelected)
    }
}

