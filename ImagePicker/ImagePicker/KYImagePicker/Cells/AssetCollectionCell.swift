//
//  AssetCollectionCell.swift
//  ImagePicker
//
//  Created by kaideyi on 2017/4/8.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class AssetCollectionCell: UICollectionViewCell {

    /// 显示的图片
    @IBOutlet weak var photoImage: UIImageView!
    
    /// 选择的按钮
    @IBOutlet weak var selectButton: UIButton!
    
    /// 图片选择的状态
    var isChecked: Bool = false {
        willSet {
            self.selectButton.isSelected = newValue
        }
    }
    
    var didSelectBtnClosure: (UIButton) -> Void = {_ in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 这里使用CALayer需要优化
        photoImage.contentMode = .scaleAspectFill
        photoImage.layer.cornerRadius = 2.0
        photoImage.layer.masksToBounds = true
        photoImage.layer.borderWidth = 0.2
        photoImage.layer.borderColor = UIColor.lightGray.cgColor
        photoImage.isUserInteractionEnabled = true
        
        selectButton.setImage(UIImage(named: "photo_normal_photo"), for: .normal)
        selectButton.setImage(UIImage(named: "photo_sel_photo"), for: .selected)
        selectButton.setImage(UIImage(named: "photo_sel_photo"), for: .highlighted)
    }
    
    @IBAction func selectBtnAction(_ sender: UIButton) {
        didSelectBtnClosure(sender)
    }
}

