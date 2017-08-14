//
//  WbStatusView.swift
//  KYWebo
//
//  Created by kaideyi on 2017/8/13.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import YYKit

class WbStatusView: UIView {
    
    // MARK: - Properites
    
    var contentBgView: UIView!  // 内容视图
    
    var profileView: WbProfileView!  // 个人资料
    
    var textLabel: YYLabel!  // 正文文本
    
    var retweetContentBgView: UIView?  // 转发视图
    
    var retweetTextLabel: YYLabel?  // 转发文本
    
    var toolbarView: WbToolbarView!  // 工具栏视图
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentBgView = UIView()
        contentBgView.size = CGSize(width: YYScreenSize().width, height: 1)
        self.addSubview(contentBgView)
        
        profileView = WbProfileView()
        profileView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kCellProfileHeight)
        contentBgView.addSubview(profileView)
        
        textLabel = YYLabel()
        textLabel.left = kCellPadding
        textLabel.width = kCellContentWidth
        textLabel.textVerticalAlignment = .top
        textLabel.displaysAsynchronously = true
        textLabel.ignoreCommonProperties = true
        textLabel.fadeOnAsynchronouslyDisplay = false
        textLabel.fadeOnHighlight = false
        textLabel.highlightTapAction = { (containerView, text, range, rect) in
            // 点击事件处理，代理到控制器中
            // ...
        }
        
        toolbarView = WbToolbarView()
        toolbarView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kCellToolbarHeight)
        contentBgView.addSubview(toolbarView)
    }
    
    // MARK: - Layout
    
    func setupStatus(withViewmodel viewModel: HomeItemViewModel) {
        self.height = viewModel.totalHeight
        contentBgView.height = viewModel.totalHeight
        
        // 对Cell里的元素布局
        var top: CGFloat = 0  // y的坐标
        
        profileView.nameLabel.textLayout = viewModel.nameTextLayout
        profileView.sourceLabel.textLayout = viewModel.sourceTextLayout
        profileView.top = top
        top += viewModel.profileHeight
        
        textLabel.textLayout = viewModel.textLayout
        textLabel.height = viewModel.textHeight
        textLabel.top = top
        top += viewModel.textHeight
        
        toolbarView.bottom = contentBgView.height
        toolbarView.top = top
    }
}

