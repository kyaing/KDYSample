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
        backBtn.setImage(UIImage(named: "navi_back"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
        
        return backBtn
    }()
    
    /// 切换相机按钮
    lazy var swtichButton: UIButton = {
        let switchbtn = UIButton()
        switchbtn.setTitle("切换镜头", for: .normal)
        switchbtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        switchbtn.isSelected = false
        switchbtn.addTarget(self, action: #selector(switchBtnAction(_:)), for: .touchUpInside)
        
        return switchbtn
    }()
    
    var backClosure: () -> Void = {}
    
    var switchClosure: (Bool) -> Void = {_ in }
    
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
        
        backButton.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        swtichButton.snp.makeConstraints { (make) in
            make.right.equalTo(self)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 80, height: 40))
        }
    }
    
    func backBtnAction() {
        backClosure()
    }
    
    func switchBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switchClosure(!sender.isSelected)
    }
}

