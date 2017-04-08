//
//  AssetCollectionCell.swift
//  ImagePicker
//
//  Created by kaideyi on 2017/4/8.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class AssetCollectionCell: UICollectionViewCell {

    @IBOutlet weak var photoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoImage.contentMode = .scaleAspectFill
        photoImage.layer.cornerRadius = 2.0
        photoImage.layer.masksToBounds = true
        photoImage.layer.borderWidth = 0.2
        photoImage.layer.borderColor = UIColor.lightGray.cgColor
    }
}

