//
//  KYHomeController.swift
//  KYWebo
//
//  Created by KYCoder on 2017/8/10.
//  Copyright © 2017年 mac. All rights reserved.
//

/**
 *  实现思路可直接参考：https://github.com/ibireme/YYKit
 */

import UIKit
import SnapKit

/// Webo首页
class KYHomeController: UIViewController {
    
    // MARK: - Properites
    
    let timelineIdentifier = "timelineCell"
    
    lazy var wbTableView: UITableView = {
        let tb = UITableView()
        tb.backgroundColor = UIColor(hexString: "#f2f2f2")
        tb.tableFooterView = UIView()
        tb.separatorStyle = .none
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
        wbTableView.register(HomeTimelineCell.classForCoder(), forCellReuseIdentifier: timelineIdentifier)
        
        wbTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    func setupTimelines() {
        viewModel.timelineSuccess = { array in
            DispatchQueue.main.async {
                self.dataSource = array as! NSMutableArray
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
        let cell = tableView.dequeueReusableCell(withIdentifier: timelineIdentifier, for: indexPath) as! HomeTimelineCell
        
        if let viewModel = dataSource[indexPath.row] as? HomeItemViewModel {
            cell.setupCell(withViewmodel: viewModel)
        }
        
        return cell
    }
}

// MARK: -

extension KYHomeController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let itemViewmodel = dataSource[indexPath.row] as? HomeItemViewModel {
            return itemViewmodel.totalHeight
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
