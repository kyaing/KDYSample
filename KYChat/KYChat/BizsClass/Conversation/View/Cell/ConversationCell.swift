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
    
    @IBOutlet weak var unReadLabel: UILabel! {
        didSet {
            unReadLabel.layer.cornerRadius = 9.0
            unReadLabel.layer.masksToBounds = true
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
    
    @IBOutlet weak var unReadLabelWidthConstraint: NSLayoutConstraint!
    
    var model: ConversationModel! {
        willSet {
            nameLabel.text = newValue.name
            contentLabel.text = newValue.lastContent
            timeLabel.text = newValue.lastTime
            
            // 处理消息数
            let counts = Int(newValue.unReadCount)!
            if counts <= 0 { return }
            unReadLabel.text = newValue.unReadCount
            
            if counts >= 10 {
                unReadLabelWidthConstraint.constant = 23
                if counts > 99 {
                    unReadLabel.text = "99+"
                }
            } else {
                unReadLabelWidthConstraint.constant = 19
            }
        }
    }
    
    // MARK: -

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        unReadLabel.backgroundColor = .red
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        unReadLabel.backgroundColor = .red
    }
}

