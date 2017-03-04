//
//  ViewController.swift
//  Timeline
//
//  Created by mac on 17/3/3.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    public lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.frame = CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height)
        tb.register(TimelinesTableCell.classForCoder(), forCellReuseIdentifier: "TimelinesCell")
        tb.tableFooterView = UIView()
        tb.dataSource = self
        tb.delegate = self
        
        self.view.addSubview(tb)
        
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Timelines"
        tableView.reloadData()
    }
}

// MARK: -
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelinesCell", for: indexPath)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80
        } else if indexPath.row == 1 {
            return 100
        } else {
            return 150
        }
    }
}

