//
//  KYNavigationController.swift
//  KYChat
//
//  Created by KYCoder on 2017/8/30.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class KYNavigationController: UINavigationController,
    UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.interactivePopGestureRecognizer?.delegate = self
        
        // 统一导航栏样式
        setupNavigationBar()
    }

    func setupNavigationBar() {
        UINavigationBar.appearance().barTintColor  = KYColor.BarTint.color
        UINavigationBar.appearance().tintColor     = .white
        UINavigationBar.appearance().isTranslucent = true
        
        // 导航栏标题
        let attributes = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 18),
            NSForegroundColorAttributeName: UIColor.white
            ]
        UINavigationBar.appearance().titleTextAttributes = attributes
        
        // BarButton标题
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [NSFontAttributeName: UIFont.systemFont(ofSize: 16),
             NSForegroundColorAttributeName: UIColor.white], for: .normal)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.interactivePopGestureRecognizer?.isEnabled = true
        
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            let button = UIButton()
            button.setBackgroundImage(KYAsset.MainBack.image, for: .normal)
            button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
            
            if let backgroundImage = button.currentBackgroundImage {
                button.frame.size = backgroundImage.size
            }
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    func backAction() {
        self.popViewController(animated: true)
    }
}
