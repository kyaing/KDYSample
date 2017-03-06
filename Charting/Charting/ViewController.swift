//
//  ViewController.swift
//  Charting
//
//  Created by kaideyi on 2017/3/5.
//  Copyright © 2017年 kaideyi.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    public lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.frame = CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height)
        tb.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tb.tableFooterView = UIView()
        tb.dataSource = self
        tb.delegate = self
        
        self.view.addSubview(tb)
        
        return tb
    }()
    
    var data: NSArray = ["1.柱形图", "2.折线图", "3.饼状图"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Charting"
        tableView.reloadData()
    }
}

// MARK: -
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row] as? String
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controller = SubViewController(indexPath.row)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

