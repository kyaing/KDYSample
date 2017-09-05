//
//  ConversationCell.swift
//  KYChat
//
//  Created by KYCoder on 2017/9/5.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import Reusable
import YYText

class ConversationCell: UITableViewCell, NibReusable {
    
    // MARK: -
    
    @IBOutlet weak var avatorImage: UIImageView! {
        didSet {
            avatorImage.layer.cornerRadius = 5.0
            avatorImage.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var nameLabel: YYLabel! {
        didSet {
            nameLabel.textColor = KYColor.TextThree.color
        }
    }
    
    @IBOutlet weak var contentLabel: YYLabel! {
        didSet {
            contentLabel.textColor = KYColor.TextSix.color
        }
    }
    
    @IBOutlet weak var timeLabel: UILabel! {
        didSet {
            timeLabel.textColor = KYColor.TextNine.color
        }
    }
    
    var model: ConversationModel! {
        willSet {
            nameLabel.text = newValue.name
            contentLabel.text = newValue.lastContent
            timeLabel.text = newValue.lastTime
        }
    }
    
    // MARK: -

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

