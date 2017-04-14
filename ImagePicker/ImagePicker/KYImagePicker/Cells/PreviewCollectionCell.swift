//
//  PreviewCollectionCell.swift
//  ImagePicker
//
//  Created by kaideyi on 2017/4/8.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class PreviewCollectionCell: UICollectionViewCell {

    @IBOutlet weak var previewImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        previewImage.contentMode = .scaleAspectFit
        previewImage.clipsToBounds = true
    }
}

