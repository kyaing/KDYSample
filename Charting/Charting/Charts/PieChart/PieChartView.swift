//
//  PieChartView.swift
//  Charting
//
//  Created by mac on 17/3/6.
//  Copyright © 2017年 kaideyi.com. All rights reserved.
//

import UIKit

/// 饼状图
class PieChartView: UIView {
    
    var pieLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        drawPiesView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawPiesView() {
        let data: [CGFloat] = [25.0, 40.0, 35.0]
        
        var startA: CGFloat = 0.0
        var endA: CGFloat = 0.0
        
        pieLayer = CAShapeLayer()
        self.layer.addSublayer(pieLayer)
        
        let innnerRadius = self.width / 6.0
        let outerRadius  = self.width / 2.0
        
        let lineWidth = outerRadius - innnerRadius
        let radius = (outerRadius + innnerRadius) * 0.5
        
        for value in data {
            endA = CGFloat(value / 100) + startA
            
            let path = UIBezierPath()
            let centerPos = self.center
            path.addArc(withCenter: centerPos, radius: radius, startAngle: -(CGFloat)(M_PI_2), endAngle: CGFloat(M_PI_2) * 3, clockwise: true)
            
            let layer = CAShapeLayer()
            layer.path = path.cgPath
            layer.lineWidth = lineWidth
            layer.strokeColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0).cgColor
            layer.fillColor = UIColor.clear.cgColor
            layer.strokeStart = startA
            layer.strokeEnd = endA
            pieLayer.addSublayer(layer)
            
            startA = endA
        }
        
        let maskLayer = drawPie()
        pieLayer.mask = maskLayer

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue   = 1.0
        animation.duration  = 1.5
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pieLayer.mask?.add(animation, forKey: nil)
    }
    
    func drawPie() -> CAShapeLayer {
        let innnerRadius = self.width / 6.0
        let outerRadius  = self.width / 2.0
        let lineWidth = outerRadius - innnerRadius
        let radius = (outerRadius + innnerRadius) * 0.5
        
        let path = UIBezierPath()
        let centerPos = self.center
        path.addArc(withCenter: centerPos, radius: radius, startAngle: -(CGFloat)(M_PI_2), endAngle: CGFloat(M_PI_2) * 3, clockwise: true)
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.lineWidth = lineWidth
        layer.strokeColor = UIColor.red.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeStart = 0.0
        layer.strokeEnd = 1.0
        
        return layer
    }
}

