//
//  Timelines.swift
//  Timeline
//
//  Created by mac on 17/3/3.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

public struct Timelines {
    
    // MARK: Properties
    var lineWidth: CGFloat = 2.0
    
    var topPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    var middlePoint: CGPoint = CGPoint(x: 0, y: 0)
    
    var downPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    public init() {
        
    }
    
    
    
    func drawLine(view: UIView) {
        drawLine(view: view, from: topPoint, to: middlePoint)
        drawLine(view: view, from: middlePoint, to: downPoint)
    }
    
    func drawLine(view: UIView, from: CGPoint, to: CGPoint) {
        let path = UIBezierPath()
        path.move(to: from)
        path.addLine(to: to)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.black.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        
        view.layer.addSublayer(shapeLayer)
    }
}

// MARK: -
public struct TimelineBubble {

    // MARK: Properties
    var diameter: CGFloat = 10.0
    
    var lineWidth: CGFloat = 2.0
    
    var centerPos = CGPoint(x: 0, y: 0)
    
    func drawBubble(view: UIView) {
        let frame = CGRect(x: centerPos.x, y: centerPos.y, width: diameter, height: diameter)
        let path = UIBezierPath(ovalIn: frame)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.black.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        
        view.layer.addSublayer(shapeLayer)
    }
}

