//
//  WbToolbarView.swift
//  KYWebo
//
//  Created by kaideyi on 2017/8/13.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import YYKit

/// 工具栏视图
class WbToolbarView: UIView {
    
    // MARK: -

    lazy var repostButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.isExclusiveTouch = true
        btn.setTitleColor(UIColor(hexString: "#999999"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return btn
    }()
    
    lazy var commentButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.isExclusiveTouch = true
        btn.setTitleColor(UIColor(hexString: "#999999"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    
        return btn
    }()
    
    lazy var likeButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.isExclusiveTouch = true
        btn.setTitleColor(UIColor(hexString: "#999999"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return btn
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.isExclusiveTouch = true
        
        self.layer.borderColor = UIColor(hexString: "#f0f0f0")?.cgColor
        self.layer.borderWidth = 0.5
        
        let width = self.width / 3.0
        let height = self.height
        
        repostButton.frame = CGRect(x: 0, y: 0, width: width, height: height)
        commentButton.frame = CGRect(x: width, y: 0, width: width, height: height)
        likeButton.frame = CGRect(x: width * 2, y: 0, width: width, height: height)
        
        self.addSubview(repostButton)
        self.addSubview(commentButton)
        self.addSubview(likeButton)
    }
}

