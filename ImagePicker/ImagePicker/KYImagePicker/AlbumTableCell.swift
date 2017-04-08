//
//  AlbumTableCell.swift
//  ImagePicker
//
//  Created by kaideyi on 2017/4/8.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class AlbumTableCell: UITableViewCell {

    @IBOutlet weak var pickerImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 修饰下 pickerImage
        pickerImage.layer.cornerRadius = 2.0
        pickerImage.layer.masksToBounds = true
        pickerImage.layer.borderWidth = 0.2
        pickerImage.layer.borderColor = UIColor.lightGray.cgColor
    }
}

