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
    var name: String = ""
    
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
    
    // MARK: -
    
    init(conversation: EMConversation) {
        super.init()
        
        self.conversation = conversation
        self.name = conversation.conversationId
        
        if conversation.type == EMConversationTypeChat {  // 普通聊天
            self.avatarImage = KYAsset.AvatarDefault.image
            
        } else {   // 群组聊天
            self.avatarImage = UIImage(named: "group_avatar")
        }
        
        self.unReadCount = String(format: "%d", conversation.unreadMessagesCount)
        self.lastTime = getlastMessageTime(conversation)
        self.lastContent = getlastMessageContent(conversation)
    }
    
    func getlastMessageTime(_ conversation: EMConversation) -> String {
        if let latestMessage = conversation.latestMessage {
            let seconds      = Double((latestMessage.timestamp)) / 1000
            let timeInterval = TimeInterval(seconds)
            let date         = Date(timeIntervalSince1970: timeInterval)
            let timeString   = Date.messageAgoSinceDate(date)
            
            return timeString
            
        } else {
            return ""
        }
    }
    
    func getlastMessageContent(_ conversation: EMConversation) -> String {
        if let latestMessage = conversation.latestMessage {
            var latestMsgTitle: String = ""
            
            switch latestMessage.body.type {
            case EMMessageBodyTypeText:
                latestMsgTitle = (latestMessage.body as! EMTextMessageBody).text
            case EMMessageBodyTypeImage:    latestMsgTitle = "[图片]"
            case EMMessageBodyTypeVideo:    latestMsgTitle = "[视频]"
            case EMMessageBodyTypeLocation: latestMsgTitle = "[位置]"
            case EMMessageBodyTypeVoice:    latestMsgTitle = "[音频]"
            default:
                latestMsgTitle = ""
            }
            return latestMsgTitle
            
        } else {
            return ""
        }
    }
}

