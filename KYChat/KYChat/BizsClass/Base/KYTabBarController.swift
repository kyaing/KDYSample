//
//  KYTabBarController.swift
//  KYChat
//
//  Created by KYCoder on 2017/8/30.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import UserNotifications

class KYTabBarController: UITabBarController {

    // MARK:
    
    // 默认播放声音的间隔
    let kDefaultPlaySoundInterval = 3.0
    let kMessageType = "MessageType"
    let kConversationChatter = "ConversationChatter"
    
    var lastPlaySoundDate: Date = Date()
    
    let conversationVC = KYConversationController()
    let contactVC = KYContactsController()
    let meVC = KYMeViewController()
    
    var connectionState: EMConnectionState = EMConnectionConnected
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
        
        setupUnReadMessages()
        setupUntreatedApplys()

        setupNotifications()
        
        KYChatHelper.share.contactVC = contactVC
        KYChatHelper.share.conversationVC = conversationVC
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(kUnReadMessagesNoti), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(kUTreatApplysNoti), object: nil)
    }
    
    func setupViewControllers() {
        let titleArray = ["Chats", "通讯录", "我"]
        
        let imagesNormal = [
            KYAsset.TabChatNormal.image,
            KYAsset.TabContactsNormal.image,
            KYAsset.TabMeNormal.image
        ]
        
        let imagesSelect = [
            KYAsset.TabChatSelect.image,
            KYAsset.TabContactsSelect.image,
            KYAsset.TabMeSelect.image
        ]
        
        let controllers = [conversationVC, contactVC, meVC]
        var navigationControllers: [KYNavigationController] = []
        
        for (index, controller) in controllers.enumerated() {
            controller.title = titleArray[index]
            controller.tabBarItem.title = titleArray[index]
            
            if let imageNormal = imagesNormal[index],
                let imageSelect = imagesSelect[index] {
                controller.tabBarItem.image = imageNormal.withRenderingMode(.alwaysOriginal)
                controller.tabBarItem.selectedImage = imageSelect.withRenderingMode(.alwaysOriginal)
            }
            
            controller.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.lightGray], for: .normal)
            controller.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: KYColor.TabbarSelectedText.color], for: .selected)
            
            let navigation = KYNavigationController(rootViewController: controller)
            navigationControllers.append(navigation)
        }
        
        self.viewControllers = navigationControllers as [KYNavigationController]
    }
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(setupUnReadMessages), name: NSNotification.Name(kUnReadMessagesNoti), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(setupUnReadMessages), name: NSNotification.Name(kUTreatApplysNoti), object: nil)
    }
    
    // MARK: - Public Methods
    
    func setupUnReadMessages() {
        if let conversations = EMClient.shared().chatManager.getAllConversations() as? [EMConversation] {
            if conversations.count == 0 { return }
            
            var unReadCounts: Int32 = 0
            for conversation in conversations {
                unReadCounts += conversation.unreadMessagesCount
            }
            
            if unReadCounts > 0 {
                conversationVC.tabBarItem.badgeValue = String("\(unReadCounts)")
            } else {
                conversationVC.tabBarItem.badgeValue = nil
            }
    
            UIApplication.shared.applicationIconBadgeNumber = Int(unReadCounts)
        }
    }

    func setupUntreatedApplys() {
        
    }
    
    func setupNetworkState(_ state: EMConnectionState) {
        connectionState = state
        conversationVC.networkIsConnected()
    }
    
    // 播放声音或振动(有新消息时)
    func playSoundAndVibration() {
        let timeInterval: TimeInterval = Date().timeIntervalSince(lastPlaySoundDate)
        if timeInterval < kDefaultPlaySoundInterval {
            // 如果距离上次响铃和震动时间太短, 则跳过响铃
            print("skip ringing & vibration \(Date()), \(lastPlaySoundDate)")
            return;
        }
        
        self.lastPlaySoundDate = Date()
        
        EMCDDeviceManager.sharedInstance().playVibration()
        EMCDDeviceManager.sharedInstance().playNewMessageSound()
    }
    
    // 显示推送消息
    func showPushNotification(withMessage message: EMMessage) {
        let pushOptions: EMPushOptions = EMClient.shared().pushOptions
        var alertBody: String = ""
        
        let title = message.from
        if pushOptions.displayStyle == EMPushDisplayStyleMessageSummary {  // 显示具体内容
            guard let messageBody = message.body else { return }
            
            var pushMessageStr: String = ""
            switch messageBody.type {
            case EMMessageBodyTypeText:     pushMessageStr = (messageBody as! EMTextMessageBody).text
            case EMMessageBodyTypeImage:    pushMessageStr = "[图片]"
            case EMMessageBodyTypeVideo:    pushMessageStr = "[视频]"
            case EMMessageBodyTypeLocation: pushMessageStr = "[位置]"
            case EMMessageBodyTypeVoice:    pushMessageStr = "[语音]"
            default:                        pushMessageStr = ""
            }
    
            alertBody = String(format: "%@: %@", title!, pushMessageStr)
            
        } else {
            alertBody = "您有一条新消息"
        }
        
        var isPlaySound = false
        let timeInterval: TimeInterval = Date().timeIntervalSince(lastPlaySoundDate)
        if timeInterval > kDefaultPlaySoundInterval {
            isPlaySound = true
        }
        
        var userInfo = [String: AnyObject]()
        userInfo[kMessageType] = NSNumber(value: message.chatType.rawValue)
        userInfo[kConversationChatter] = message.conversationId as AnyObject
        
        // 发送本地通知
        if #available(iOS 10, *) {
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
            let content = UNMutableNotificationContent()
            
            content.body = alertBody
            content.userInfo = userInfo
            if isPlaySound {
                content.sound = UNNotificationSound.default()
            }
            
            let request = UNNotificationRequest(identifier: message.messageId, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
        } else {
            let notification = UILocalNotification()
            notification.fireDate = Date()
            notification.alertBody = alertBody
            notification.userInfo = userInfo
            if isPlaySound {
                notification.soundName = UILocalNotificationDefaultSoundName
            }
    
            UIApplication.shared.scheduleLocalNotification(notification)
        }
    }
}

