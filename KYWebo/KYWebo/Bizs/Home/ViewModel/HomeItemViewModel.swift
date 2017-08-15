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
let kCellPadding: CGFloat         = 10   // cell内边距
let kCellInsetPadding: CGFloat    = 8
let kCellPaddingText: CGFloat     = 5    // cell 文本与其他元素间留白
let kCellToolbarHeight: CGFloat   = 35   // 底部工具栏高度
let kScreenWidth: CGFloat         = YYScreenSize().width   // 屏幕宽
let kScreenHeight: CGFloat        = YYScreenSize().height  // 屏幕高

let kCellContentLeft: CGFloat     = kCellInsetPadding * 2 + kCellAvatorWidth  // 文本距左距离
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
        layoutPictures()
        layoutRetweet()
        layoutToolbar()
        
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
        let bodyAttriText = parseText(withModel: wbstatus,
                                      isRetweet: false,
                                      fontSize: kCellTextFontSize,
                                      textColor: UIColor(hexString: "#333333")!)
        
        let modifier = WbTextLinePositionModifier()
        modifier.font = UIFont(name: "Heiti SC", size: kCellTextFontSize)
        modifier.paddingTop = kCellPaddingText
        modifier.paddingBottom = kCellPaddingText
        
        let textContainer: YYTextContainer = YYTextContainer(size: CGSize(width: kCellContentWidth, height: CGFloat(HUGE)))
        textContainer.linePositionModifier = modifier
        textLayout = YYTextLayout(container: textContainer, text: bodyAttriText)
        
        textHeight = modifier.lineHeight(forLineCount: textLayout.rowCount)
    }
    
    func layoutPictures() {
        
    }
    
    func layoutRetweet() {
        
    }
    
    func layoutToolbar() {
        totalHeight = kCellToolbarHeight
    }
    
    // MARK: - Private Methods
    
    // 解析富文本中的: #话题#；@人名；图片；链接等
    func parseText(withModel model: WbStatus, isRetweet: Bool, fontSize: CGFloat, textColor: UIColor) -> NSMutableAttributedString {
        let bodyText = model.text
        
        let attritext = NSMutableAttributedString(string: bodyText)
        attritext.font = UIFont.systemFont(ofSize: fontSize)
        attritext.color = textColor
        
        // 提取超链接
        parseTextLink(fromText: attritext)
        
        return attritext
    }
    
    func parseTextLink(fromText attritext: NSMutableAttributedString) {
        let regularStr = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
        
        let regex = try! NSRegularExpression(pattern: regularStr, options: .caseInsensitive)
        let matchesArray: [NSTextCheckingResult] = regex.matches(in: attritext.string, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, attritext.string.characters.count))
        
        let newString = attritext.string as NSString
        var urlArray: [String] = []
        
        for match in matchesArray {
            let substring = newString.substring(with: match.range)
            print("substring = \(substring)")
            urlArray.append(substring)
        }
        
        for url in urlArray {
            let newString = attritext.string as NSString
            var searchRange = NSRange(location: 0, length: newString.length)
            
            let range = newString.range(of: url, options: NSString.CompareOptions(rawValue: 0), range: searchRange)
            if range.location == NSNotFound { break }
            
            if range.location + range.length == attritext.length {
                attritext.replaceCharacters(in: range, with: "")
                break
            }
            
            if attritext.attribute(YYTextHighlightAttributeName, at: UInt(range.location)) == nil {
                let replace   = NSMutableAttributedString(string: "网页链接")
                replace.font  = UIFont.systemFont(ofSize: kCellNameFontSize)
                replace.color = UIColor(hexString: "#527ead")
                
                if range.location + range.length > attritext.length {
                    break
                }
                attritext.replaceCharacters(in: range, with: replace)
                
                searchRange.location = searchRange.location + ((replace.length > 0) ? replace.length : 1)
                if (searchRange.location + 1 >= attritext.length) { break }
                searchRange.length = attritext.length - searchRange.location
                
            } else{
                searchRange.location = searchRange.location + ((searchRange.length > 0) ? searchRange.length : 1)
                if (searchRange.location + 1 >= attritext.length) { break }
                searchRange.length = attritext.length - searchRange.location
            }
        }
    }
    
    func parseTextTopic(fromText attritext: NSMutableAttributedString) {
        
    }
    
    func parseTextEmotion(fromText attritext: NSMutableAttributedString) {
        
    }
    
    func parseTextAt(fromText attritext: NSMutableAttributedString) {
        
    }
}

extension String {
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
    }
}

extension String {
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location + nsRange.length, limitedBy: utf16.endIndex),
            let from = from16.samePosition(in: self),
            let to = to16.samePosition(in: self)
            else { return nil }
        
        return from ..< to
    }
}

