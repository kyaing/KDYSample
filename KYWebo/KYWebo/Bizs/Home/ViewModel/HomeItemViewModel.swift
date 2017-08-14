//
//  HomeItemViewModel.swift
//  KYWebo
//
//  Created by KYCoder on 2017/8/11.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import YYKit

let kCellProfileHeight: CGFloat   = 56   // 个人资料视图高度
let kCellAvatorWidth: CGFloat     = 40   // 头像宽度
let kCellPadding: CGFloat         = 12   // cell内边距
let kCellPaddingText: CGFloat     = 10   // cell 文本与其他元素间留白
let kCellToolbarHeight: CGFloat   = 30   // 底部工具栏高度
let kScreenWidth: CGFloat         = YYScreenSize().width   // 屏幕宽
let kScreenHeight: CGFloat        = YYScreenSize().height  // 屏幕高

let kCellContentLeft: CGFloat     = kCellPadding * 2 + kCellAvatorWidth  // 文本距左距离
let kCellContentWidth: CGFloat    = kScreenWidth - kCellPadding - kCellContentLeft  // 内容宽度
let kCellNameWidth: CGFloat       = kScreenWidth - 80  // 名字宽度
let kCellToolBarTop: CGFloat      = 8   // 工具栏与它之上间间距
let kCellTopMargin: CGFloat       = 8
let kCellBottomMargin: CGFloat    = 2

let kCellNameFontSize: CGFloat    = 16  // 名字字体大小
let kCellSourceFontSize: CGFloat  = 12  // 来源字体大小
let kCellTextFontSize: CGFloat    = 17  // 文本字体大小

/// 每个Cell的viewModel
class HomeItemViewModel: NSObject {

    // MARK: - Properites
    
    var wbstatus: WbStatus!
    
    var topMargin: CGFloat = 0           // 顶部留白
    var bottomMargin: CGFloat = 0        // 底部留白
    
    var profileHeight: CGFloat = 0       // 个人资料高度
    var nameTextLayout: YYTextLayout!    // 名字布局
    var sourceTextLayout: YYTextLayout!  // 来源布局
    
    var textHeight: CGFloat = 0          // 文本高度
    var textLayout: YYTextLayout!        // 文本布局
    
    var toolbarHeight: CGFloat = 0       // 工具栏高度
    var toolbarLayout: YYTextLayout!     // 工具栏布局
    
    var totalHeight: CGFloat = 0         // 总高度
    
    // MARK: - Life Cycle
    
    init(withStatus status: WbStatus) {
        super.init()
        wbstatus = status
        layoutCell()
    }
    
    // MARK: - Layout
    
    func layoutCell() {
        layoutProfile()
        layoutBodyText()
        layoutToolbaar()
        
        topMargin = kCellTopMargin
        bottomMargin = kCellBottomMargin
        
        totalHeight += topMargin
        totalHeight += profileHeight
        totalHeight += textHeight
        totalHeight += kCellToolBarTop
        totalHeight += toolbarHeight
        totalHeight += bottomMargin
    }
    
    func layoutProfile() {
        layoutProfileName()
        layoutProfileSource()
        
        profileHeight = kCellProfileHeight
    }
    
    func layoutProfileName() {
        let user = wbstatus.user
        
        var nameString: String = ""
        if user.remark.characters.count > 0 {
            nameString = user.remark
        } else if user.screenName.characters.count > 0 {
            nameString = user.screenName
        } else {
            nameString = user.name
        }
        
        // 名字的富文本
        let nameAttriText = NSMutableAttributedString(string: nameString)
        nameAttriText.font = UIFont.systemFont(ofSize: kCellNameFontSize)
        nameAttriText.color = UIColor(hexString: "#333333")
        nameAttriText.lineBreakMode = .byCharWrapping
        
        let nameContainer: YYTextContainer = YYTextContainer(size: CGSize(width: kCellNameWidth, height: 9999))
        nameContainer.maximumNumberOfRows = 1
        nameTextLayout = YYTextLayout(container: nameContainer, text: nameAttriText)
    }
    
    func layoutProfileSource() {
        let createTime = wbstatus.createdAt
        
        // 来源的富文本
        let sourceAttriText = NSMutableAttributedString(string: createTime)
        sourceAttriText.font = UIFont.systemFont(ofSize: kCellSourceFontSize)
        sourceAttriText.color = UIColor(hexString: "#828282")
        
        let sourceContainer: YYTextContainer = YYTextContainer(size: CGSize(width: kCellNameWidth, height: 9999))
        sourceContainer.maximumNumberOfRows = 1
        sourceTextLayout = YYTextLayout(container: sourceContainer, text: sourceAttriText)
    }
    
    func layoutBodyText() {
        let bodyText = wbstatus.text
        
        let bodyAttriText = NSMutableAttributedString(string: bodyText)
        bodyAttriText.font = UIFont.systemFont(ofSize: kCellTextFontSize)
        bodyAttriText.color = UIColor(hexString: "#333333")
        
        let modifier = WbTextLinePositionModifier()
        modifier.font = UIFont(name: "Heiti SC", size: kCellTextFontSize)
        modifier.paddingTop = kCellPaddingText
        modifier.paddingBottom = kCellPaddingText
        
        let textContainer: YYTextContainer = YYTextContainer(size: CGSize(width: kCellContentWidth, height: CGFloat(HUGE)))
        textContainer.linePositionModifier = modifier
        textLayout = YYTextLayout(container: textContainer, text: bodyAttriText)

        textHeight = modifier.lineHeight(forLineCount: textLayout.rowCount)
    }
    
    func layoutToolbaar() {
        totalHeight = kCellToolbarHeight
    }
    
    // MARK: - Private Methods 

}

