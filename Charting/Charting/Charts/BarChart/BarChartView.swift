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
    
    // MARK:
    
    /// bar的间距
    var margin: CGFloat = 15.0
    
    var barWidth: CGFloat = 0.0
    
    var xLabelWidth: CGFloat = 0.0
    
    /// x轴的内容
    var xLabels = [String]() {
        didSet {
            xLabelWidth = self.width / CGFloat(xLabels.count)
        }
    }
    
    /// y轴的内容
    var yLabels = [CGFloat]()
    
    // MARK:
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
        xPath.move(to: CGPoint(x: 0, y: self.height))
        xPath.addLine(to: CGPoint(x: self.width, y: self.height))
        xPath.lineCapStyle = .square
        
        let xLayer = CAShapeLayer()
        xLayer.lineWidth = 1.0
        xLayer.strokeColor = UIColor.gray.cgColor
        xLayer.path = xPath.cgPath
        xLayer.lineCap = kCALineCapButt
        self.layer.addSublayer(xLayer)
    
        // y axis
        let yPath = UIBezierPath()
        yPath.move(to: CGPoint(x: 0, y: self.height))
        yPath.addLine(to: CGPoint(x: 0, y: 0))
        yPath.lineCapStyle = .square
        
        let yLayer = CAShapeLayer()
        yLayer.lineWidth = 1.0
        yLayer.strokeColor = UIColor.gray.cgColor
        yLayer.path = yPath.cgPath
        yLayer.lineCap = kCALineCapButt
        self.layer.addSublayer(yLayer)
    }
    
    func drawBars() {
        
        var index: Int = 0
        for value in yLabels {
            var xPos: CGFloat = 0.0
            
            if barWidth > 0 {
                xPos = xLabelWidth * CGFloat(index) + (xLabelWidth - barWidth) * 0.5
            } else {
                xPos = xLabelWidth * CGFloat(index) + xLabelWidth * 0.5
            }
            
            let bar = BarView(frame: CGRect(x: xPos, y: 0, width: barWidth, height: self.height))
            bar.grade = (value / self.height)
            
            self.addSubview(bar)
            
            index += 1
        }
    }
}

