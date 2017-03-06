//
//  UIColor+Extension.swift
//  Charting
//
//  Created by kaideyi on 2017/3/6.
//  Copyright © 2017年 kaideyi.com. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func RGB(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    
    class func RGBAlpha(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
}

