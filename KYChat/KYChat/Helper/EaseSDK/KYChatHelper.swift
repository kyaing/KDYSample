//
//  KYChatHelper.swift
//  KYChat
//
//  Created by KYCoder on 2017/8/30.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class KYChatHelper: NSObject {
    
    // MARK: -
    
    var mainTabbarVC: KYTabBarController?
    var conversationVC: KYConversationController?
    var contactVC: KYContactsController?
    
    static let share = KYChatHelper()
    private override init() {
        super.init()
        self.initHeapler()
    }
    
    func initHeapler() {
        EMClient.shared().add(self, delegateQueue: nil)
        EMClient.shared().chatManager.add(self, delegateQueue: nil)
        EMClient.shared().contactManager.add(self, delegateQueue: nil)
        EMClient.shared().groupManager.add(self, delegateQueue: nil)
    }
    
    deinit {
        EMClient.shared().removeDelegate(self)
        EMClient.shared().chatManager.remove(self)
        EMClient.shared().contactManager.removeDelegate(self)
        EMClient.shared().groupManager.removeDelegate(self)
    }
    
    // MARK: -
    
    func asyncPushOptions() {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async { 
            var error: EMError?
            EMClient.shared().getPushOptionsFromServerWithError(&error)
        }
    }
    
    func asyncConversationFromDB() {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async { 
            if let conversations = EMClient.shared().chatManager.getAllConversations() {
                (conversations as NSArray).enumerateObjects({ (emConversation, idx, stop) in
                    
                    let conversation = (emConversation as! EMConversation)
                    if conversation.latestMessage == nil {
                        // 当消息为空则删除
                        EMClient.shared().chatManager.deleteConversation(conversation.conversationId,
                                                                         isDeleteMessages: true, completion: nil)
                    }
                })
            }
        }
        
        DispatchQueue.main.async { 
            if let tabbarVC = self.mainTabbarVC {
                tabbarVC.setupUnReadMessages()
                tabbarVC.setupUntreatedApplys()
            }
            
            if let converVC = self.conversationVC {
                converVC.getChatConversations()
            }
        }
    }
}

extension KYChatHelper: EMClientDelegate {
    
}

extension KYChatHelper: EMChatManagerDelegate {
    
}

extension KYChatHelper: EMContactManagerDelegate {
    
}

extension KYChatHelper: EMGroupManagerDelegate {
    
}


