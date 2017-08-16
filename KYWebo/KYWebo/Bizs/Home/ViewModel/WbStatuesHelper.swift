//
//  WbStatuesHelper.swift
//  KYWebo
//
//  Created by KYCoder on 2017/8/16.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import YYKit

class WbStatuesHelper: NSObject {
    
    class func getImageCache() -> YYMemoryCache {
        let sharedInstance = YYMemoryCache()
        sharedInstance.shouldRemoveAllObjectsOnMemoryWarning = false
        sharedInstance.shouldRemoveAllObjectsWhenEnteringBackground = false
        sharedInstance.name = "WeboImageCache"
        
        return sharedInstance
    }
    
    class func getImage(fromPath path: String) -> UIImage? {
        guard let image = getImageCache().object(forKey: path) as? UIImage else {

            var _image: UIImage?
            let newPath = path as NSString
            if newPath.pathScale() == 1 {
                // 查找 @2x @3x 的图片
                let scales = Bundle.preferredScales()
                for scale in scales {
                    guard let image = UIImage(contentsOfFile: newPath.appendingPathScale(CGFloat(scale.floatValue))) else { return nil }
                    _image = image
                }
                
            } else {
                guard let image = UIImage(contentsOfFile: path) else { return nil }
                _image = image
            }
            
            if _image != nil {
                _image = _image?.byDecoded()
                getImageCache().setObject(_image, forKey: path)
            }
            return _image
        }
        
        return image
    }
}

