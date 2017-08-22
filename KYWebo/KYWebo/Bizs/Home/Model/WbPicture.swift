//
//  WbPicture.swift
//  KYWebo
//
//  Created by KYCoder on 2017/8/21.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class WbPicture: NSObject {
    
    var thumbnail: String = ""  // 缩略图
    var bmiddle: String = ""    // 中图
    var large: String = ""      // 大图
    
    var size: CGSize = .zero    // 图片的尺寸(中图的)，怎么计算得到？
    
    public static func modelCustomPropertyMapper() -> [String : Any]? {
        return [
            "thumbnail" : "thumbnail_pic"
        ]
    }
}
