//
//  KYTabBarController.swift
//  KYChat
//
//  Created by KYCoder on 2017/8/30.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class KYTabBarController: UITabBarController {

    // MARK:
    
    let conversationVC = KYConversationController()
    let contactVC = KYContactsController()
    let meVC = KYMeViewController()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    fileprivate func setupViewControllers() {
        let titleArray = ["Chat", "通讯录", "我"]
        
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
    
    // MARK: - Public Methods
    
    func setupUnReadMessages() {
        
    }
    
    func setupUntreatedApplys() {
        
    }
}

