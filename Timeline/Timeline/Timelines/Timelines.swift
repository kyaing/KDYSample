//
//  Timelines.swift
//  Timeline
//
//  Created by mac on 17/3/3.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

public struct TimelineBubble {
    
    // MARK: Properties
    
    var diameter: CGFloat = 10.0
    
    var lineWidth: CGFloat = 2.0
    
    /// 圆心点
    var centerPos = CGPoint(x: 0, y: 0)
    
    // MARK: Draw
    func drawBubble(view: UIView) {
        let frame = CGRect(x: centerPos.x, y: centerPos.y, width: diameter, height: diameter)
        let path  = UIBezierPath(ovalIn: frame)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.black.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        view.layer.addSublayer(shapeLayer)
    }
}

// MARK: -
public struct Timelines {
    
    // MARK: Properties
    
    /// 线宽
    var lineWidth: CGFloat = 2.0
    
    /// 起点
    var startPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    /// 中点
    var middlePoint: CGPoint = CGPoint(x: 0, y: 0)
    
    /// 终点
    var endPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    /// 线上部分的颜色
    var upColor: UIColor = .black
    
    /// 线下部分的颜色
    var downColor: UIColor = .black
    
    // MARK: Life Cycle
    public init() {
        self.init(width: 2.0, upColor: .black, downColor: .black)
    }
    
    public init(upColor: UIColor, downColor: UIColor) {
        self.init(width: 2.0, upColor: upColor, downColor: downColor)
    }
    
    public init(width: CGFloat, upColor: UIColor, downColor: UIColor) {
        self.lineWidth = width
        self.upColor   = upColor
        self.downColor = downColor
    }
    
    // MARK: Draw
    func drawLine(view: UIView) {
        drawLine(view: view, from: startPoint, to: middlePoint, color: upColor)
        drawLine(view: view, from: middlePoint, to: endPoint, color: downColor)
    }
    
    func drawLine(view: UIView, from: CGPoint, to: CGPoint, color: UIColor) {
        let path = UIBezierPath()
        path.move(to: from)
        path.addLine(to: to)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.black.cgColor
        shapeLayer.strokeColor = color.cgColor
        view.layer.addSublayer(shapeLayer)
    }
}

