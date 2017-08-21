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
    
    var contentBgView: UIView!       // 内容视图
    
    var profileView: WbProfileView!  // 个人资料
    
    var textLabel: YYLabel!          // 正文文本
    
    var picsView: UIView!
    
    var retweetBgView: UIView!       // 转发视图
    
    var retweetTextLabel: YYLabel!   // 转发文本
    
    var retweetPicsView: UIView!
    
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
        // 内容视图
        contentBgView = UIView()
        contentBgView.backgroundColor = .white
        contentBgView.size = CGSize(width: kScreenWidth, height: 1)
        self.addSubview(contentBgView)
        
        // 个人资料
        profileView = WbProfileView()
        profileView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kCellProfileHeight)
        contentBgView.addSubview(profileView)
        
        // 正文
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
        
        picsView = UIView()
        picsView.backgroundColor = .red
        picsView.left = kCellContentLeft
        picsView.width = kCellContentWidth
        contentBgView.addSubview(picsView)
        
        // 转发视图
        retweetBgView = UIView()
        retweetBgView.left  = kCellContentLeft
        retweetBgView.width = kCellContentWidth
        retweetBgView.backgroundColor = UIColor(hexString: "#f7f7f7")
        contentBgView.addSubview(retweetBgView)
        
        // 转发文本
        retweetTextLabel = YYLabel()
        retweetTextLabel.left  = kCellReteetLeft
        retweetTextLabel.width = kCellReteetWidth
        retweetTextLabel.textVerticalAlignment = .top
        retweetTextLabel.displaysAsynchronously = true
        retweetTextLabel.ignoreCommonProperties = true
        retweetTextLabel.fadeOnAsynchronouslyDisplay = false
        retweetTextLabel.fadeOnHighlight = false
        retweetTextLabel.highlightTapAction = { (containerView, text, range, rect) in
            // 点击事件处理，代理到控制器中
            // ...
        }
        contentBgView.addSubview(retweetTextLabel)
        
        retweetPicsView = UIView()
        retweetPicsView.backgroundColor = .blue
        retweetPicsView.left = kCellReteetLeft
        retweetPicsView.width = kCellReteetWidth
        contentBgView.addSubview(retweetPicsView)
        
        // 工具栏
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
        
        // Cell里的元素布局
        var top: CGFloat = 0  // y轴的坐标
        
        // 个人资料
        let avatarUrl = URL(string: (viewModel.wbstatus?.user.avatarLarge)!)
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
        
        // 先隐藏元素
        retweetBgView.isHidden = true
        retweetTextLabel.isHidden = true
        retweetPicsView.isHidden = true
        picsView.isHidden = true
        
        // 转发视图，展示的优先级：转发->图片
        if viewModel.retweetHeight > 0 {
            retweetBgView.isHidden = false
            retweetBgView.height = viewModel.retweetHeight
            retweetBgView.top = top
            
            if let textlayout = viewModel.retweetTextLayout {
                retweetTextLabel.isHidden = false
                retweetTextLabel.textLayout = textlayout
                retweetTextLabel.height = viewModel.retweetTextHeight
                retweetTextLabel.top = top
            }
            
            // 有转发的图片或视频
            if viewModel.retweetPicsHeight > 0 {
                retweetPicsView.isHidden = false
                retweetPicsView.height = viewModel.retweetPicsHeight
                retweetPicsView.top = retweetTextLabel.bottom
                
                setPicsImage(withViewModel: viewModel, isRetweet: true)
            }
            
        } else if viewModel.picsHeight > 0  {
            picsView.isHidden = false
            picsView.height = viewModel.picsHeight
            picsView.top = textLabel.bottom
            
            setPicsImage(withViewModel: viewModel, isRetweet: false)
        }
        
        // 工具栏
        toolbarView.bottom = contentBgView.height
    }
    
    func setPicsImage(withViewModel viewModel: HomeItemViewModel, isRetweet: Bool) {
        guard let model = viewModel.wbstatus else { return }
        
        var picArray: [WbPicture] = []
        var height: CGFloat = 0
        
        if isRetweet {
            guard let array = model.retweetedStatus?.picUrls else { return }
            picArray = array
            height = viewModel.retweetPicSize.height
            
            retweetPicsView.removeAllSubviews()  // 移除子视图
            
            var i = 0
            for pic in picArray {  // 创建九宫格
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFill
                imageView.layer.masksToBounds = true
                imageView.setImageWith(URL(string: pic.thumbnail), placeholder: nil)
                retweetPicsView.addSubview(imageView)
                
                let row = i / 3  // 3 为列数
                let col = i % 3
                let margin: CGFloat = 5
                
                let xPos = CGFloat(col) * CGFloat(height + margin)
                let yPos = CGFloat(row) * CGFloat(height + margin)
                imageView.frame = CGRect(x: xPos, y: yPos, width: height, height: height)
                
                i += 1
            }
            
        } else {
            picArray = model.picUrls
            height = viewModel.picSize.height
            
            picsView.removeAllSubviews()  // 移除子视图
            
            var i = 0
            for pic in picArray {  // 创建九宫格
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFill
                imageView.layer.masksToBounds = true
                imageView.setImageWith(URL(string: pic.thumbnail), placeholder: nil)
                picsView.addSubview(imageView)
                
                let row = i / 3  // 3 为列数
                let col = i % 3
                let margin: CGFloat = 5
                
                let xPos = CGFloat(col) * CGFloat(height + margin)
                let yPos = CGFloat(row) * CGFloat(height + margin)
                imageView.frame = CGRect(x: xPos, y: yPos, width: height, height: height)
                
                i += 1
            }
        }
    }
}

