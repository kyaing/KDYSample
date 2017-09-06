//
//  KYChatHelper+Delegate.swift
//  KYChat
//
//  Created by KYCoder on 2017/9/6.
//  Copyright © 2017年 mac. All rights reserved.
//

import Foundation

// MARK: - EMClientDelegate

extension KYChatHelper: EMClientDelegate {
 
    // 监测网络的变化
    func connectionStateDidChange(_ aConnectionState: EMConnectionState) {
        if let tabbarVC = self.mainTabbarVC {
            tabbarVC.setupNetworkState(aConnectionState)
        }
    }
}

// MARK: - EMChatManagerDelegate

extension KYChatHelper: EMChatManagerDelegate {
    
    // 会话列表发生变化
    func conversationListDidUpdate(_ aConversationList: [Any]!) {
        if let tabbarVC = self.mainTabbarVC {
            tabbarVC.setupUnReadMessages()
        }
        
        if let converVC = self.conversationVC {
            converVC.refreshConversations()
        }
    }
    
    // 接收新的消息
    func messagesDidReceive(_ aMessages: [Any]!) {
        
        for message in aMessages as! [EMMessage] {
            let needPushnotification = (message.chatType == EMChatTypeChat)
            
            if needPushnotification {
#if !TARGET_IPHONE_SIMULATOR
                let applicationState = UIApplication.shared.applicationState
        
                switch applicationState {
                case .active, .inactive:
                    if let tabbarVC = self.mainTabbarVC {
                        tabbarVC.playSoundAndVibration()
                    }
                    
                case .background:
                    if let tabbarVC = self.mainTabbarVC {
                        tabbarVC.showNotification(withMessage: message)
                    }
                }
#endif
            }
            
            if let tabbarVC = self.mainTabbarVC {
                tabbarVC.setupUnReadMessages()
            }
    
            if let converVC = self.conversationVC {
                converVC.refreshConversations()
            }
        }
    }
}

// MARK: - EMContactManagerDelegate

extension KYChatHelper: EMContactManagerDelegate {
    
}

// MARK: - EMGroupManagerDelegate

extension KYChatHelper: EMGroupManagerDelegate {
    
}

