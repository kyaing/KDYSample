//
//  WbEmotion.swift
//  KYWebo
//
//  Created by KYCoder on 2017/8/16.
//  Copyright © 2017年 mac. All rights reserved.
//
//  描述：根据 EmotiocnWeibo.bunle中的资源建立 Model
//

import UIKit

class WbEmotion: NSObject {
    var chs: String  = ""   // 中文简体 [吃惊]
    var cht: String  = ""   // 中文繁体 [吃驚]
    var gif: String  = ""   // gif图
    var png: String  = ""   // 图片
    var code: String = ""
    var group: WbEmoticonGroup = WbEmoticonGroup()
    
    public static func modelPropertyBlacklist() -> [String]? {
        return ["group"]
    }
}

class WbEmoticonGroup: NSObject {
    var groupId: String     = ""
    var version: Int        = 0
    var nameCN: String      = ""
    var nameEn: String      = ""
    var nameTW: String      = ""
    var groupType: Int      = 0
    var displayOnly: Int    = 0
    var emoticons: Array<WbEmotion> = []

    public static func modelCustomPropertyMapper() -> [String : Any]? {
        return [
            "groupID"       : "id",
            "nameCN"        : "group_name_cn",
            "nameEn"        : "group_name_en",
            "nameTW"        : "group_name_tw",
            "displayOnly"   : "display_only",
            "groupType"     : "group_type"
        ]
    }
    
    public static func modelContainerPropertyGenericClass() -> [String : Any]? {
        return ["emoticons": WbEmotion.classForCoder()]
    }
}

