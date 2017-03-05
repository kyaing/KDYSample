//
//  TimelinesTableCell.swift
//  Timeline
//
//  Created by kaideyi on 2017/3/5.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class TimelinesTableCell: UITableViewCell {

    // MARK: Properties
    
    /// 时间标题
    @IBOutlet weak var titleLabel: UILabel!
    
    /// 正文内容
    @IBOutlet weak var contentLabel: UILabel!
    
    /// 绘制的线
    var timeline = Timelines()
    
    /// 绘制的节点
    var timelineBubble = TimelineBubble()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Draw
    override func draw(_ rect: CGRect) {
        
        let xPos = titleLabel.x * 0.5 + timeline.lineWidth * 0.5
        let yPos = titleLabel.y + titleLabel.intrinsicContentSize.height * 0.5 - timelineBubble.diameter * 0.5

        timelineBubble.centerPos = CGPoint(x: xPos, y: yPos)
        timelineBubble.drawBubble(view: self.contentView)
        
        timeline.startPoint  = CGPoint(x: timelineBubble.centerPos.x + timelineBubble.diameter / 2.0, y: 0)
        timeline.middlePoint = CGPoint(x: timeline.startPoint.x, y: timelineBubble.centerPos.y)
        timeline.endPoint    = CGPoint(x: timeline.startPoint.x, y: self.bounds.height)
        timeline.drawLine(view: self.contentView)
    }
}

