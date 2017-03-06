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

        if index == 0 {
            self.title = "BarChart"
            setupBarChartView()
        } else if index == 1 {
            self.title = "LineChart"
            setupLineChartView()
        } else {
            self.title = "PieChart"
            setupPieChartView()
        }
    }
    
    func setupBarChartView() {
        let barView = BarChartView(frame: CGRect(x: (self.view.width - 350)/2.0, y: 200, width: 350, height: 300))
        self.view.addSubview(barView)
    }
    
    func setupLineChartView() {
        
    }
    
    func setupPieChartView() {
        
    }
}

