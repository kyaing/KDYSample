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
    
    var tagsView: WbTagsView!  // 标签视图
    
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
        contentBgView.width = UIScreen.main.bounds.width
        contentBgView.height = 1
        self.addSubview(contentBgView)
        
        
    }
    
    // MARK: - 
    
    func setupStatus(withViewmodel viewModel: HomeItemViewModel) {
        
    }
}

