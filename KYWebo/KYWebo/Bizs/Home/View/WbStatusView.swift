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
    
    var picsView: UIView!            // 图片视图
    
    var retweetBgView: UIView!       // 转发视图
    
    var retweetTextLabel: YYLabel!   // 转发文本
    
    var retweetPicsView: UIView!     // 转发图片视图
    
    var toolbarView: WbToolbarView!  // 工具栏视图
    
    var isTouchRetweetView: Bool = false
    
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
        contentBgView.isExclusiveTouch = true
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
        picsView.backgroundColor = .clear
        picsView.left = kCellContentLeft
        picsView.width = kCellContentWidth
        contentBgView.addSubview(picsView)
        
        // 转发视图
        retweetBgView = UIView()
        retweetBgView.isExclusiveTouch = true
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
        retweetPicsView.backgroundColor = .clear
        retweetPicsView.left = kCellReteetLeft
        retweetPicsView.width = kCellReteetWidth
        contentBgView.addSubview(retweetPicsView)
        
        // 工具栏
        toolbarView = WbToolbarView(frame:
            CGRect(x: 0, y: 0, width: kCellContentWidth, height: kCellToolbarHeight))
        toolbarView.left = kCellContentLeft
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
        
        retweetBgView.isHidden = true
        retweetTextLabel.isHidden = true
        retweetPicsView.isHidden = true
        picsView.isHidden = true
        
        // 转发视图，展示的优先级：转发->图片
        if viewModel.retweetHeight > 0 {
            retweetBgView.isHidden = false
            retweetBgView.height = viewModel.retweetHeight
            retweetBgView.top = top + kCellPaddingText
            
            if let textlayout = viewModel.retweetTextLayout {
                retweetTextLabel.isHidden = false
                retweetTextLabel.textLayout = textlayout
                retweetTextLabel.height = viewModel.retweetTextHeight
                retweetTextLabel.top = top + kCellPaddingText
            }
            
            // 有转发的图片或视频
            if viewModel.retweetPicsHeight > 0 {
                retweetPicsView.isHidden = false
                retweetPicsView.height = viewModel.retweetPicsHeight
                retweetPicsView.top = retweetTextLabel.bottom + kCellPaddingText
                
                setPicsImage(withViewModel: viewModel, isRetweet: true)
            }
            
        } else if viewModel.picsHeight > 0  {
            picsView.isHidden = false
            picsView.height = viewModel.picsHeight
            picsView.top = textLabel.bottom + kCellPaddingText
            
            setPicsImage(withViewModel: viewModel, isRetweet: false)
        }
        
        // 工具栏
        toolbarView.bottom = contentBgView.height
        
        if viewModel.wbstatus?.repostsCount != 0 {
            toolbarView.repostButton.setTitle(String.init(format: "转发 %d", (viewModel.wbstatus?.repostsCount)!), for: .normal)
        } else {
            toolbarView.repostButton.setTitle("转发", for: .normal)
        }
        
        if viewModel.wbstatus?.commentsCount != 0 {
            toolbarView.commentButton.setTitle(String.init(format: "评论 %d", (viewModel.wbstatus?.commentsCount)!), for: .normal)
        } else {
            toolbarView.commentButton.setTitle("评论", for: .normal)
        }
        
        if viewModel.wbstatus?.attitudesCount != 0 {
            toolbarView.likeButton.setTitle(String.init(format: "点赞 %d", (viewModel.wbstatus?.attitudesCount)!), for: .normal)
        } else {
            toolbarView.likeButton.setTitle("点赞", for: .normal)
        }
    }
    
    func setPicsImage(withViewModel viewModel: HomeItemViewModel, isRetweet: Bool) {
        guard let model = viewModel.wbstatus else { return }
        
        var picArray: [WbPicture] = []
        var width: CGFloat = 0
        var height: CGFloat = 0
        
        if isRetweet {
            guard let array = model.retweetedStatus?.picUrls else { return }
            picArray = array
            width = viewModel.retweetPicSize.width
            height = viewModel.retweetPicSize.height
                
            retweetPicsView.removeAllSubviews()
            
        } else {
            picArray = model.picUrls
            width = viewModel.picSize.width
            height = viewModel.picSize.height
            
            picsView.removeAllSubviews()
        }
        
        var i = 0
        for pic in picArray {  // 创建九宫格（暂为对gif、长图的处理）
            let imageView = YYControl()
            imageView.clipsToBounds = true
            imageView.backgroundColor = UIColor(hexString: "#f0f0f0")
            imageView.isExclusiveTouch = true
            imageView.layer.borderWidth = 0.5
            imageView.layer.borderColor = UIColor(hexString: "#f0f0f0")?.cgColor
            imageView.touchBlock = { (view, state, touches, evnet) in
                // 点击了图片的事件
            }
            
            pic.bmiddle = pic.thumbnail.replacingOccurrences(of: "thumbnail", with: "bmiddle")
            imageView.layer.setImageWith(URL(string: pic.bmiddle), placeholder: nil, options: .avoidSetImage,
                completion: { (image, url, from, stage, error) in
                    // 需要处理图片(横图、竖图、小图，长图等)
                    
                    imageView.contentMode = .scaleAspectFill;
                    imageView.image = image
                })
            
            if isRetweet {
                retweetPicsView.addSubview(imageView)
            } else {
                picsView.addSubview(imageView)
            }
            
            let row = i / 3  // 3 为列数
            let col = i % 3
            let margin: CGFloat = kCellPaddingPic
            
            let xPos = CGFloat(col) * CGFloat(height + margin)
            let yPos = CGFloat(row) * CGFloat(height + margin)
            
            if picArray.count == 1 {
                imageView.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
            } else {
                imageView.frame = CGRect(x: xPos, y: yPos, width: height, height: height)
            }
            
            i += 1
        }
    }
    
    // MARK: - Touchs
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let point: CGPoint = touch.location(in: retweetBgView)
        let insideRetweet = retweetBgView.bounds.contains(point)
        
        if insideRetweet && !retweetBgView.isHidden {
            isTouchRetweetView = true
            retweetBgView.perform(#selector(setter: UIView.backgroundColor), with: UIColor(hexString: "#f0f0f0"), afterDelay: 0.15)
            
        } else {
            isTouchRetweetView = false
            contentBgView.perform(#selector(setter: UIView.backgroundColor), with: UIColor(hexString: "#f0f0f0"), afterDelay: 0.15)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setupBgviewColor()
        
        if isTouchRetweetView {
            
        } else {
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        setupBgviewColor()
    }
    
    func setupBgviewColor() {
        // 取消上次的延迟
        NSObject.cancelPreviousPerformRequests(withTarget: retweetBgView, selector: #selector(setter: UIView.backgroundColor), object: UIColor(hexString: "#f0f0f0"))
        NSObject.cancelPreviousPerformRequests(withTarget: contentBgView, selector: #selector(setter: UIView.backgroundColor), object: UIColor(hexString: "#f0f0f0"))
        
        // 设置背景颜色
        contentBgView.backgroundColor = .white
        retweetBgView.backgroundColor = UIColor(hexString: "#f7f7f7")
    }
}

