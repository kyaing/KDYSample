//
//  SlideFlowLayout.swift
//  SlideTabBar
//
//  Created by mac on 17/2/20.
//  Copyright © 2017年 kaideyi.com. All rights reserved.
//

import UIKit

/// 滚动视图的流布局
class SlideFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
        self.itemSize = (self.collectionView?.size)!
        
        self.scrollDirection = .horizontal
    }
}

