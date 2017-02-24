//
//  CycleScrollCell.swift
//  CycleView
//
//  Created by mac on 17/2/24.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class CycleScrollCell: UICollectionViewCell {
    
    public var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.bounds
    }
}

