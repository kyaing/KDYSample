//
//  WbProfileView.swift
//  KYWebo
//
//  Created by kaideyi on 2017/8/13.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import YYKit

/// 个人资料视图
class WbProfileView: UIView {
    
    lazy var avatarIamge: UIImageView = {
        let avatar = UIImageView()
        avatar.contentMode = .scaleAspectFill
        return avatar
    }()
    
    lazy var nameLabel: YYLabel = {
        let name = YYLabel()
        name.displaysAsynchronously = true
        name.ignoreCommonProperties = true
        name.fadeOnAsynchronouslyDisplay = false
        name.fadeOnHighlight = false
        name.textVerticalAlignment = .center
        name.lineBreakMode = .byClipping
        
        return name
    }()
    
    lazy var sourceLabel: YYLabel = {
        let source = YYLabel()
        source.displaysAsynchronously = true
        source.ignoreCommonProperties = true
        source.fadeOnAsynchronouslyDisplay = false
        source.fadeOnHighlight = false
        
        return source
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(avatarIamge)
        
        self.addSubview(nameLabel)
        
        sourceLabel.highlightTapAction = { (containerView, text, range, rect) in
            // 点击事件处理，代理到控制器中
            // ...
        }
        self.addSubview(sourceLabel)
        
        avatarIamge.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).inset(UIEdgeInsetsMake(kCellPadding, kCellPadding, 0, 0))
            make.size.equalTo(CGSize(width: kCellAvatorWidth, height: kCellAvatorWidth))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarIamge.snp.top)
            make.left.equalTo(avatarIamge.snp.right).offset(kCellPadding)
            make.size.equalTo(CGSize(width: kCellNameWidth, height: 22))
        }
        
        sourceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.equalTo(avatarIamge.snp.right).offset(kCellPadding)
            make.size.equalTo(CGSize(width: kCellNameWidth, height: 18))
        }
    }
}

