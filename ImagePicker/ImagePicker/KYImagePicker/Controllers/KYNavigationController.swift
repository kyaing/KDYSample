//
//  KYNavigationController.swift
//  ImagePicker
//
//  Created by mac on 17/3/29.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

/// 自定义导航控制器
class KYNavigationController: UINavigationController {
    
    // MARK: - Properties
    
    /// 导航栏背景色
    var naviBarColor: UIColor {
        set { self.naviBarColor = newValue }
        get { return UIColor(colorLiteralRed: 34/255.0, green: 34/255.0, blue: 34/255.0, alpha: 0.6) }
    }
    
    /// 导航栏标题色
    var naviTitleColor: UIColor {
        set { self.naviTitleColor = newValue }
        get { return UIColor.white }
    }
    
    /// 导航栏标题字体
    var naviTitleFont: UIFont {
        set { self.naviTitleFont = newValue }
        get { return UIFont.systemFont(ofSize: 19) }
    }
    
    /// 导航按钮颜色
    var barItemTitleColor: UIColor {
        set { self.barItemTitleColor = newValue }
        get { return UIColor.white }
    }
    
    /// 导航按钮字体
    var barItemTitleFont: UIFont {
        set { self.barItemTitleFont = newValue }
        get { return UIFont.systemFont(ofSize: 17) }
    }
    
    /// 改变状态栏样式
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
    // MARK: - Methods

    // 修改导航栏各种样式
    func configureAppearance() {
        UINavigationBar.appearance().barTintColor = naviBarColor
        UINavigationBar.appearance().tintColor = UIColor.white
        
        UINavigationBar.appearance().isTranslucent = true
        let attributes = [
                NSFontAttributeName: naviTitleFont,
                NSForegroundColorAttributeName: naviTitleColor
            ] as [String : Any]
        UINavigationBar.appearance().titleTextAttributes = attributes
        
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [NSFontAttributeName: barItemTitleFont,
             NSForegroundColorAttributeName: barItemTitleColor], for: UIControlState())
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            self.hidesBottomBarWhenPushed = true

            // 自定义返回按钮
            let backButton = UIButton()
            backButton.setBackgroundImage(UIImage(named: "main_back"), for: UIControlState())
            backButton.addTarget(self, action: #selector(backItemAction), for: .touchUpInside)
            backButton.frame.size = (backButton.currentBackgroundImage?.size)!
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        }
        
        super.pushViewController(viewController, animated: true)
    }
    
    func backItemAction() {
        self.popViewController(animated: true)
    }
}

