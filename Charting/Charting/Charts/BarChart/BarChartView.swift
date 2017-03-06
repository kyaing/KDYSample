//
//  BarChartView.swift
//  Charting
//
//  Created by mac on 17/3/6.
//  Copyright © 2017年 kaideyi.com. All rights reserved.
//

import UIKit

/// 柱状图
class BarChartView: UIView {
    
    /// bar之间的间距
    var margin: CGFloat = 15.0
    
    /// x轴的内容
    var xLable = [String]() {
        didSet {
            
        }
    }
    
    /// y轴的内容
    var yLabel = [String]() {
        didSet {
            
        }
    }
    
    /// bar的宽度
    var barWidth: CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        drawXYAxis()
        drawBars()
    }
    
    func drawXYAxis() {
        // x axis
        let xPath = UIBezierPath()
        xPath.move(to: CGPoint(x: margin, y: self.height - margin))
        xPath.addLine(to: CGPoint(x: self.width - margin, y: self.height - margin))
        xPath.lineCapStyle = .square
        
        let xLayer = CAShapeLayer()
        xLayer.lineWidth = 1.0
        xLayer.strokeColor = UIColor.gray.cgColor
        xLayer.path = xPath.cgPath
        xLayer.lineCap = kCALineCapButt
        self.layer.addSublayer(xLayer)
    
        // y axis
        let yPath = UIBezierPath()
        yPath.move(to: CGPoint(x: margin, y: self.height - margin))
        yPath.addLine(to: CGPoint(x: margin, y: margin))
        yPath.lineCapStyle = .square
        
        let yLayer = CAShapeLayer()
        yLayer.lineWidth = 1.0
        yLayer.strokeColor = UIColor.gray.cgColor
        yLayer.path = yPath.cgPath
        yLayer.lineCap = kCALineCapButt
        self.layer.addSublayer(yLayer)
    }
    
    func drawBars() {
        
    }
}

