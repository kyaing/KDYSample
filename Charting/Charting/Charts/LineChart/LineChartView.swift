//
//  LineChartView.swift
//  Charting
//
//  Created by mac on 17/3/6.
//  Copyright © 2017年 kaideyi.com. All rights reserved.
//

import UIKit
import CoreGraphics

/// 折线图
class LineChartView: UIView {
    
    // MARK: Properites
    
    var gradientLayer: CAGradientLayer!
    
    var gradiendBgView: UIView!
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    
        drawGradientView()
        drawLine()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Draw
    func drawLine() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 10, y: self.height))
        path.addLine(to: CGPoint(x: 100, y: 100))
        path.addLine(to: CGPoint(x: 160, y: 50))
        path.addLine(to: CGPoint(x: 200, y: 120))
        path.addLine(to: CGPoint(x: 300, y: 200))
        
        let lineLayer = CAShapeLayer()
        lineLayer.path = path.cgPath
        lineLayer.lineWidth = 2.0
        lineLayer.strokeColor = UIColor.blue.cgColor
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.lineCap = kCALineCapButt
        self.layer.addSublayer(lineLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue   = 1.0
        animation.duration  = 2.0
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        lineLayer.add(animation, forKey: nil)
    }
    
    func drawGradientView() {
        gradiendBgView = UIView()
        // 渐变层视图要除去坐标轴
        gradiendBgView.frame = CGRect(x: 2, y: 0, width: self.width - 2, height: self.height - 2)
        self.addSubview(gradiendBgView)
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradiendBgView.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0)
        gradientLayer.colors = [UIColor.yellow.cgColor, UIColor.red.cgColor]
        //gradiendBgView.layer.addSublayer(gradientLayer)
        
        drawDashLine()
    }
    
    func drawDashLine() {
        let path = UIBezierPath()
        path.lineWidth = 1.0
        
        path.move(to: CGPoint(x: 0, y: 50))
        path.addLine(to: CGPoint(x: self.width-2, y: 50))
        
        path.move(to: CGPoint(x: 0, y: 100))
        path.addLine(to: CGPoint(x: self.width-2, y: 100))
        
        path.move(to: CGPoint(x: 0, y: 150))
        path.addLine(to: CGPoint(x: self.width-2, y: 150))
        
        let dashLayer = CAShapeLayer()
        dashLayer.path = path.cgPath
        dashLayer.strokeColor = UIColor.orange.cgColor
        
        let arr: NSArray = NSArray(array: [5, 5])
        dashLayer.lineDashPhase = 1.0
        dashLayer.lineDashPattern = arr as? [NSNumber]
        gradiendBgView.layer.addSublayer(dashLayer)
    }
    
    override func draw(_ rect: CGRect) {
        // 尝试用CG库绘制xy轴
        guard let context = UIGraphicsGetCurrentContext() else { return }
    
        context.setLineWidth(2.0)
        context.setStrokeColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        context.move(to: CGPoint(x: 0, y: rect.height))
        context.addLine(to: CGPoint(x: rect.width, y: rect.height))
        context.move(to: CGPoint(x: 0, y: rect.height))
        context.addLine(to: CGPoint(x: 0, y: 0))
        context.strokePath()
    }
}

