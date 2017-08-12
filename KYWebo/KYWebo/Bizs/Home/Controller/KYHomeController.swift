//
//  KYHomeController.swift
//  KYWebo
//
//  Created by KYCoder on 2017/8/10.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import SnapKit

/// Webo首页
class KYHomeController: UIViewController {
    
    // MARK: - Properites
    
    lazy var wbTableView: UITableView = {
        let tb = UITableView()
        tb.tableFooterView = UIView()
        tb.dataSource = self
        tb.delegate = self
        
        return tb
    }()
    
    lazy var viewModel: HomeViewModel = {
        let viewmodel = HomeViewModel()
        return viewmodel
    }()
    
    var dataSource: NSMutableArray = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Webo"
        self.view.backgroundColor = .white
        
        setupViews()
        setupTimelines()
    }
    
    func setupViews() {
        view.addSubview(wbTableView)
        wbTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    func setupTimelines() {
        viewModel.timelineSuccess = { item in
            print("status counts = \(item.statuses.count)")
            
            DispatchQueue.main.async {
                self.dataSource.addObjects(from: item.statuses)
                self.wbTableView.reloadData()
            }
        }
        
        viewModel.timelineFailed = { error in
            print("error = \(error)")
        }
    }
}

// MARK: -

extension KYHomeController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: -

extension KYHomeController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
