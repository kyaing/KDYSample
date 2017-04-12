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
    
    /// 返回按钮
    lazy var backButton: UIButton = {
        let back = UIButton()
        back.setImage(UIImage(named: "navi_back"), for: .normal)
        back.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
        
        return back
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:
    
    func setupViews() {
        self.addSubview(backButton)
        
        backButton.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
    }
    
    func backBtnAction() {
        
    }
}

