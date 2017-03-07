//
//  SubViewController.swift
//  Charting
//
//  Created by mac on 17/3/6.
//  Copyright © 2017年 kaideyi.com. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {

    var index: NSInteger!
    
    var titlesData: NSArray = ["BarChart", "LineChart", "PieChart"]
    
    // MARK:
    init(_ index: NSInteger) {
        super.init(nibName: nil, bundle: nil)
        self.index = index
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.title = titlesData[index] as? String
        
        switch index {
        case 0: setupBarView()
        case 1: setupLineView()
        case 2: setupPieView()
        default:
            break
        }
    }
    
    // MARK:
    func setupBarView() {
        let barView = BarChartView(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        barView.center   = self.view.center
        barView.xLabels  = ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"]
        barView.yLabels  = [50, 100, 200, 260, 80, 150, 50, 100, 200, 260, 80, 280]
        barView.barWidth = 20.0
        self.view.addSubview(barView)
    }
    
    func setupLineView() {
        let lineView = LineChartView(frame: CGRect(x: 0, y: 0, width: 320, height: 220))
        lineView.center = self.view.center
        self.view.addSubview(lineView)
    }
    
    func setupPieView() {
        let pieView = PieChartView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        pieView.backgroundColor = .red
        pieView.center = self.view.center
        self.view.addSubview(pieView)
    }
}

