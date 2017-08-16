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

let kWbLinkHrefName: String  =  "href"
let kWbLinkUrlName: String   =  "url"
let kWbLinkTopicName: String =  "topic"
let kWbLinkAtName: String    =  "at"

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
    
    // 解析富文本中的: #话题#；@好友；表情；链接等
    func parseText(withModel model: WbStatus, isRetweet: Bool, fontSize: CGFloat, textColor: UIColor) -> NSMutableAttributedString {
        let bodyText = model.text
        
        let attritext = NSMutableAttributedString(string: bodyText)
        attritext.font = UIFont.systemFont(ofSize: fontSize)
        attritext.color = textColor
        
        parseTextLink(fromText: attritext)      // 解析链接
        parseTextTopic(fromText: attritext)     // 解析话题
        parseTextEmotion(fromText: attritext)   // 解析表情
        parseTextAt(fromText: attritext)        // 解析@
        
        return attritext
    }
    
    func parseTextLink(fromText attritext: NSMutableAttributedString) {
        let regularStr = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
        let matchesArray = setupRegexArray(regularStr: regularStr, attritext: attritext)
        
        let newString = attritext.string as NSString
        var urlArray: [String] = []
        
        for match in matchesArray {
            let substring = newString.substring(with: match.range)
            print("url substring = \(substring)")
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
                let replace   = NSMutableAttributedString(string: "网页链接")  // 暂且使用 "网页链接"
                replace.font  = UIFont.systemFont(ofSize: kCellTextFontSize)
                replace.color = UIColor(hexString: "#527ead")
                
                // 高亮状态
                let highlight = YYTextHighlight()
                highlight.setBackgroundBorder(setupHightlight())
                highlight.userInfo = [kWbLinkUrlName: url]  // 存储数据
                replace.setTextHighlight(highlight, range: NSRange(location: 0, length: replace.length))
                
                if range.location + range.length > attritext.length {
                    break
                }
                attritext.replaceCharacters(in: range, with: replace)
                
                searchRange.location = searchRange.location + ((replace.length > 0) ? replace.length : 1)
                if (searchRange.location + 1 >= attritext.length) { break }
                searchRange.length = attritext.length - searchRange.location
            }
        }
    }
    
    func parseTextTopic(fromText attritext: NSMutableAttributedString) {
        let regularStr = "#[^@#]+?#"
        let matchesArray = setupRegexArray(regularStr: regularStr, attritext: attritext)
        
        let newString = attritext.string as NSString
        for match in matchesArray {
            if match.range.location == NSNotFound && match.range.length <= 1 { continue }
            
            if attritext.attribute(YYTextHighlightAttributeName, at: UInt(match.range.location)) == nil {
                attritext.setFont(UIFont.systemFont(ofSize: kCellTextFontSize), range: match.range)
                attritext.setColor(UIColor(hexString: "#527ead"), range: match.range)
                
                // 高亮状态
                let highlight = YYTextHighlight()
                highlight.setBackgroundBorder(setupHightlight())
                
                let substring = newString.substring(with: NSRange(location: match.range.location + 1, length: match.range.length - 2)) as NSString
                print("topic substring = \(substring)")
                
                highlight.userInfo = [kWbLinkAtName: newString]  // 存储数据
                attritext.setTextHighlight(highlight, range: match.range)
            }
        }
    }
    
    func parseTextEmotion(fromText attritext: NSMutableAttributedString) {
        let regularStr = "\\[[^ \\[\\]]+?\\]"
        let matchesArray = setupRegexArray(regularStr: regularStr, attritext: attritext)
        let newString = attritext.string as NSString
        
        var emoClipLength: Int = 0
        for match in matchesArray {
            if match.range.location == NSNotFound && match.range.length <= 1 { continue }
            
            var range = match.range
            range.location -= emoClipLength  // 注意 location的变化
            
            let substring = newString.substring(with: match.range)
            print("emotion substring = \(substring)")
            
            if attritext.attribute(YYTextHighlightAttributeName, at: UInt(range.location)) != nil { continue }
            if attritext.attribute(YYTextAttachmentAttributeName, at: UInt(range.location)) != nil { continue }
            
            if let imagePath = getEmoticonDic()?.object(forKey: substring) as? String {
                if let image = WBStatusHelper.image(withPath: imagePath) {
                    let emotionText = NSAttributedString.attachmentString(withEmojiImage: image, fontSize: kCellTextFontSize)
                    attritext.replaceCharacters(in: range, with: emotionText!)
                    emoClipLength += range.length - 1
                }
            }
        }
    }
    
    func parseTextAt(fromText attritext: NSMutableAttributedString) {
        let regularStr = "@[0-9a-zA-Z\\u4e00-\\u9fa5]+"
        let matchesArray = setupRegexArray(regularStr: regularStr, attritext: attritext)
        
        let newString = attritext.string as NSString
        for match in matchesArray {
            if match.range.location == NSNotFound && match.range.length <= 1 { continue }
            
            if attritext.attribute(YYTextHighlightAttributeName, at: UInt(match.range.location)) == nil {
                attritext.setFont(UIFont.systemFont(ofSize: kCellTextFontSize), range: match.range)
                attritext.setColor(UIColor(hexString: "#527ead"), range: match.range)
                
                // 高亮状态
                let highlight = YYTextHighlight()
                highlight.setBackgroundBorder(setupHightlight())
                
                let substring = newString.substring(with: NSRange(location: match.range.location + 1, length: match.range.length - 1)) as NSString
                print("at substring = \(substring)")
                
                highlight.userInfo = [kWbLinkAtName: substring]  // 存储数据
                attritext.setTextHighlight(highlight, range: match.range)
            }
        }
    }
    
    func setupHightlight() -> YYTextBorder {
        let highlightBorder = YYTextBorder()
        highlightBorder.insets = UIEdgeInsetsMake(-2, -1, -2, -1)
        highlightBorder.cornerRadius = 3.0
        highlightBorder.fillColor = UIColor(hexString: "#bfdffe")
        
        return highlightBorder
    }
    
    func setupRegexArray(regularStr str: String,
                         attritext: NSMutableAttributedString) -> [NSTextCheckingResult] {

        let regex = try! NSRegularExpression(pattern: str, options: .caseInsensitive)
        let matchesArray = regex.matches(in: attritext.string,
                                         options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                         range: attritext.rangeOfAll()) as [NSTextCheckingResult]
        
        return matchesArray
    }
    
    func getEmoticonDic() -> NSDictionary? {
        guard let bundlePath = Bundle.main.path(forResource: "EmoticonWeibo.bundle", ofType: nil) else {
            return nil
        }
        let dic = getEmoticonDic(fromPath: bundlePath)
        
        return dic
    }
    
    func getEmoticonDic(fromPath path: String) -> NSMutableDictionary? {
        let emotionDic = NSMutableDictionary()
        
        let _path = path as NSString
        let jsonPath = _path.appendingPathComponent("info.json")
        
        var json: NSData?
        var group: WbEmoticonGroup?
        
        json = try? NSData(contentsOfFile: jsonPath)
        if (json != nil) {
            group = WbEmoticonGroup.model(withJSON: json!)
        }
        
        if group == nil {
            let plistPath = _path.appendingPathComponent("info.plist")
            if let plist = NSDictionary(contentsOfFile: plistPath) {
                group = WbEmoticonGroup.model(withJSON: plist)
            }
        }
        
        if group != nil {
            for emotion in (group?.emoticons)! {
                if emotion.png.characters.count == 0 { continue }
                let pngPath = _path.appendingPathComponent(emotion.png)
                
                if emotion.chs.characters.count > 0 {
                    emotionDic[emotion.chs] = pngPath
                }
                if emotion.cht.characters.count > 0 {
                    emotionDic[emotion.cht] = pngPath
                }
            }
        }

        let folders: [String]? = try? FileManager.default.contentsOfDirectory(atPath: path)
        
        if let _folders = folders {
            for folder in _folders {
                if folder.characters.count == 0 { continue }
                
                // 递归处理表情
                if let subDic = getEmoticonDic(fromPath: _path.appendingPathComponent(folder)) {
                    if subDic.count > 0 {
                        emotionDic.addEntries(from: subDic as! [AnyHashable : Any])
                    }
                }
            }
        }
        
        return emotionDic
    }
}

