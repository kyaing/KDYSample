//
//  WbUser.swift
//  KYWebo
//
//  Created by KYCoder on 2017/8/11.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import YYKit

/// 用户类型模型
class WbUser: NSObject {

    var userID: Int = 0                  // 用户id
    var userIDStr: String = ""           // 用户id String
    var genderString: String = ""        // 性别 "m":男 "f":女 "n"未知
    var desc: String = ""                // 描述
    var domain: String = ""              // 个人域名
    
    var name: String = ""                // 昵称
    var screenName: String = ""          // 友好昵称
    var remark: String = ""              // 备注
    
    var followersCount: Int = 0          // 粉丝数
    var friendsCount: Int = 0            // 关注数
    var biFollowersCount: Int = 0        // 好友数
    var favouritesCount: Int = 0         // 收藏数
    var statusesCount: Int = 0           // 微博数
    var topicsCount: Int = 0             // 话题数
    var blockedCount: Int = 0            // 屏蔽数
    
    var province: String = ""            // 省
    var city: String = ""                // 市
    
    var blogUrl: String = ""             // 博客地址
    var profileImageURL: String = ""     // 头像地址 50*50
    var avatarLarge: String = ""         // 头像地址 180*180
    var avatarHD: String = ""            // 头像地址 原图
    var coverImagePhone: String = ""
    var profileURL: String = ""
    
    var createdAt: Date = Date()         // 创建时间
    
    public static func modelCustomPropertyMapper() -> [String : Any]? {
        return [
            "userID"            : "id",
            "userIDStr"         : "idString",
            "genderString"      : "gender",
            "desc"              : "description",
            "screenName"        : "screen_name",
            "followersCount"    : "followers_count",
            "friendsCount"      : "friends_count",
            "biFollowersCount"  : "bi_followers_count",
            "favouritesCount"   : "favourites_count",
            "statusesCount"     : "statuses_count",
            "topicsCount"       : "topics_count",
            "blockedCount"      : "blocked_count",
            "profileImageURL"   : "profile_image_url",
            "avatarLarge"       : "avatar_large",
            "avatarHD"          : "avatar_hd",
            "coverImagePhone"   : "cover_image_phone",
            "profileURL"        : "profile_url",
            "createdAt"         : "created_at"
        ]
    }
}

