//
//  WbTextLinePositionModifier.swift
//  KYWebo
//
//  Created by KYCoder on 2017/8/14.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import YYKit

class WbTextLinePositionModifier: NSObject {
    
    var font: UIFont!                   // Heiti SC/PingFang SC
    var paddingTop: CGFloat = 0         // 文本顶部留白
    var paddingBottom: CGFloat = 0      // 文本底部留白
    var lineHeightMultiple: CGFloat = 0 // 行距倍数
    
    override init() {
        super.init()
        lineHeightMultiple = 1.34  // for PingFang SC
    }
    
    func lineHeight(forLineCount lineCount: UInt) -> CGFloat {
        if lineCount == 0 {
            return 0
        }
        
        let ascent: CGFloat = font.pointSize * 0.86
        let descent: CGFloat = font.pointSize * 0.14
        let lineHeight: CGFloat = font.pointSize * lineHeightMultiple
        
        return paddingTop + paddingBottom + ascent + descent + CGFloat(lineCount - 1) * lineHeight
    }
}

extension WbTextLinePositionModifier: YYTextLinePositionModifier {
    
    func copy(with zone: NSZone? = nil) -> Any {
        let one: WbTextLinePositionModifier = self
        one.font = font
        one.paddingTop = paddingTop
        one.paddingBottom = paddingBottom
        one.lineHeightMultiple = lineHeightMultiple
        
        return one
    }
    
    func modifyLines(_ lines: [YYTextLine], fromText text: NSAttributedString, in container: YYTextContainer) {
        let ascent: CGFloat = font.pointSize * 0.86
        let lineHeight: CGFloat = font.pointSize * lineHeightMultiple
        
        for line in lines {
            var position = line.position
            position.y = paddingTop + ascent + CGFloat(line.row) * lineHeight
            
            line.position = position
        }
    }
}
