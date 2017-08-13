//
//  WbStatus.swift
//  KYWebo
//
//  Created by KYCoder on 2017/8/11.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import YYKit

class WbStatus: NSObject {
    
    var statusID: Int = 0
    var statusIdstr: String = ""
    var createdAt: String = ""
    
    var user: WbUser = WbUser()
    var userType: Int = 0
    
    var text: String = ""               // 正文
    var thumbnailPic: String = ""       // 缩略图
    var bmiddlePic: String = ""         // 中图
    var originalPic: String = ""        // 原图
    
    var retweetedStatus: WbStatus?      // 转发的微博
    
    var repostsCount: Int = 0           // 转发数
    var commentsCount: Int = 0          // 评论数
    var attitudesCount: Int = 0         // 点赞数
    
    var inReplyToScreenName: String = ""
    var inReplyToStatusId: String = ""
    var inReplyToUserId: String = ""
    
    var source: String = ""             // 来源
    var sourceType: Int = 0
    var sourceAllowClick: Int = 0       // 是否可以点击
    
    
    public static func modelCustomPropertyMapper() -> [String : Any]? {
        return [
            "statusID"              : "id",
            "statusIdstr"           : "idstr",
            "createdAt"             : "created_at",
            "inReplyToScreenName"   : "in_reply_to_screen_name",
            "inReplyToStatusId"     : "in_reply_to_status_id",
            "inReplyToUserId"       : "in_reply_to_user_id",
            "sourceType"            : "source_type",
            "repostsCount"          : "reposts_count",
            "commentsCount"         : "comments_count",
            "attitudesCount"        : "attitudes_count",
            "thumbnailPic"          : "thumbnail_pic",
            "bmiddlePic"            : "bmiddle_pic",
            "originalPic"           : "original_pic"
        ]
    }
}

