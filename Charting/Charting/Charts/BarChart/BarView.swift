//
//  BarView.swift
//  Charting
//
//  Created by mac on 17/3/6.
//  Copyright © 2017年 kaideyi.com. All rights reserved.
//

import UIKit

class BarView: UIView {
    
    /// 柱形图层
    var barShapeLayer: CAShapeLayer!
    
    /// 柱形高占比
    var grade: CGFloat = 0 {
        
        didSet {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0.0
            animation.toValue   = 1.0
            animation.duration  = 1.5
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            barShapeLayer.add(animation, forKey: nil)
            
            let barPath = UIBezierPath()
            barPath.move(to: CGPoint(x: self.width * 0.5, y: self.height))
            barPath.addLine(to: CGPoint(x: self.width * 0.5, y: self.height * (1 - grade)))
            barPath.lineCapStyle = .square
            barShapeLayer.path = barPath.cgPath
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.RGB(220, 220, 220)
        
        barShapeLayer = CAShapeLayer()
        barShapeLayer.lineWidth = self.width
        barShapeLayer.lineCap = kCALineCapButt
        barShapeLayer.fillColor = UIColor.gray.cgColor
        barShapeLayer.strokeColor = UIColor.blue.cgColor
        self.layer.addSublayer(barShapeLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

