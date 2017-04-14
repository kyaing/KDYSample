//
//  KYCollectionFlowLayout.swift
//  ImagePicker
//
//  Created by kaideyi on 2017/4/9.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class KYCollectionFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
        self.itemSize = (self.collectionView?.size)!
        
        self.scrollDirection = .horizontal
    }
}

