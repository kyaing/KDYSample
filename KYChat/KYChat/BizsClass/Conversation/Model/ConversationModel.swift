//
//  ConversationModel.swift
//  KYChat
//
//  Created by KYCoder on 2017/9/5.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class ConversationModel: NSObject {

    /// 会话
    var conversation: EMConversation!
    
    /// 标题
    var title: String = ""
    
    /// 头像地址
    var avatarURLPath: String = ""
    
    /// 头像图片
    var avatarImage: UIImage!
    
    /// 最新消息内容
    var lastContent: String = ""
    
    /// 消息时间
    var lastTime: String = ""
    
    /// 消息未读数
    var unReadCount: String = ""
    
    init(conversation: EMConversation) {
        self.conversation = conversation
        self.title = conversation.conversationId
        
        if conversation.type == EMConversationTypeChat {  // 普通聊天
            self.avatarImage = KYAsset.AvatarDefault.image
            
        } else {   // 群组聊天
            self.avatarImage = UIImage(named: "group_avatar")
        }
    }
}

