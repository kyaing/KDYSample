//
//  TimelinesTableCell.swift
//  Timeline
//
//  Created by mac on 17/3/3.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class TimelinesTableCell: UITableViewCell {

    // MARK: Properties
    
    var timeline = Timelines()
    
    var timelineBubble = TimelineBubble()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func draw(_ rect: CGRect) {
        timelineBubble.centerPos = CGPoint(x: 40 + timeline.lineWidth / 2.0, y: 20)
        timelineBubble.drawBubble(view: self.contentView)
        
        timeline.topPoint    = CGPoint(x: timelineBubble.centerPos.x + timelineBubble.diameter / 2.0, y: 0)
        timeline.middlePoint = CGPoint(x: timeline.topPoint.x, y: timelineBubble.centerPos.y)
        timeline.downPoint   = CGPoint(x: timeline.topPoint.x, y: self.bounds.height)
        timeline.drawLine(view: self.contentView)
    }
}

