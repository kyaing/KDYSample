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
        contentBgView.backgroundColor = .white
        contentBgView.size = CGSize(width: YYScreenSize().width, height: 1)
        self.addSubview(contentBgView)
        
        profileView = WbProfileView()
        profileView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kCellProfileHeight)
        contentBgView.addSubview(profileView)
        
        textLabel = YYLabel()
        textLabel.left  = kCellContentLeft
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
        contentBgView.addSubview(textLabel)
        
        toolbarView = WbToolbarView()
        toolbarView.left = kCellContentLeft
        toolbarView.size = CGSize(width: kCellContentWidth, height: kCellToolbarHeight)
        contentBgView.addSubview(toolbarView)
    }
    
    // MARK: - Layout
    
    func setupStatus(withViewmodel viewModel: HomeItemViewModel) {
        self.height = viewModel.totalHeight
        
        contentBgView.top    = viewModel.topMargin
        contentBgView.height = viewModel.totalHeight - viewModel.topMargin - viewModel.bottomMargin
        
        // 依次对Cell里的元素布局
        var top: CGFloat = 0  // y的坐标
        
        // 个人资料
        let avatarUrl = URL(string: viewModel.wbstatus.user.avatarLarge)
        profileView.avatarIamge.setImageWith(avatarUrl, placeholder: nil)
        profileView.nameLabel.textLayout = viewModel.nameTextLayout
        profileView.sourceLabel.textLayout = viewModel.sourceTextLayout
        profileView.top = top
        top += viewModel.profileHeight
        
        // 正文文本
        textLabel.textLayout = viewModel.textLayout
        textLabel.height = viewModel.textHeight
        textLabel.top = top
        top += viewModel.textHeight
        
        // 工具栏
        toolbarView.bottom = contentBgView.height
    }
}

