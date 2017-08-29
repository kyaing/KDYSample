//
//  WbConfig.swift
//  KYWebo
//
//  Created by KYCoder on 2017/8/22.
//  Copyright © 2017年 mac. All rights reserved.
//

import Foundation
import YYKit

let kCellProfileHeight: CGFloat   = 56   // 个人资料视图高度
let kCellAvatorWidth: CGFloat     = 40   // 头像宽度
let kCellPadding: CGFloat         = 12   // cell内边距
let kCellInsetPadding: CGFloat    = 8
let kCellPaddingText: CGFloat     = 5    // cell 文本与其他元素间留白
let kCellPaddingPic: CGFloat      = 4    // 图片与图片之间的留白
let kCellToolbarHeight: CGFloat   = 35   // 底部工具栏高度
let kScreenWidth: CGFloat         = YYScreenSize().width   // 屏幕宽
let kScreenHeight: CGFloat        = YYScreenSize().height  // 屏幕高

let kCellContentLeft: CGFloat     = kCellPadding  // 文本距左距离
let kCellContentWidth: CGFloat    = kScreenWidth - kCellPadding * 2  // 内容宽度
let kCellNameWidth: CGFloat       = kScreenWidth - 80  // 名字宽度
let kCellToolBarTop: CGFloat      = 8   // 工具栏与它之上间间距
let kCellTopMargin: CGFloat       = 8
let kCellBottomMargin: CGFloat    = 2

let kCellNameFontSize: CGFloat    = 15  // 名字字体大小
let kCellSourceFontSize: CGFloat  = 12  // 来源字体大小
let kCellTextFontSize: CGFloat    = 16  // 文本字体大小

let kCellReteetTextSize: CGFloat  = 15  // 转发文本字体大小
let kCellReteetLeft: CGFloat      = kCellPadding + kCellPaddingText  // 转发文本距左距离
let kCellReteetWidth: CGFloat     = kCellContentWidth - kCellPaddingText * 2  // 转发内容宽度

let kWbLinkHrefName: String  =  "href"
let kWbLinkUrlName: String   =  "url"
let kWbLinkTopicName: String =  "topic"
let kWbLinkAtName: String    =  "at"

