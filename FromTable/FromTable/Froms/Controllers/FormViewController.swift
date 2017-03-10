//
//  FormViewController.swift
//  FromTable
//
//  Created by mac on 17/3/9.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {

    // MARK: Properties
    
    let config = ConfigureData()
    
    var inputCommit: UserInputsCommit!
    
    public lazy var formTableView: UITableView = {
        let tb = UITableView()
        tb.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "formCell")
        tb.tableFooterView = UIView()
        tb.sectionHeaderHeight = 48
        tb.rowHeight = 50
        tb.dataSource = self
        tb.delegate = self
        
        self.view.addSubview(tb)
        
        return tb
    }()
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        config.start()
        
        formTableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        formTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
}

// MARK: -

extension FormViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return config.getOriginalItems().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dic   = config.getOriginalItems().object(at: section) as! NSDictionary
        let array = dic.value(forKey: "subs") as! NSArray
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "formCell")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionView = UIView()
        sectionView.backgroundColor = .gray
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.red
        sectionView.addSubview(label)
        
        let dic = config.getOriginalItems().object(at: section) as! NSDictionary
        label.text = dic.value(forKey: "title") as! String?

        label.snp.makeConstraints { (make) in
            make.centerY.equalTo(sectionView)
            make.left.equalTo(sectionView).offset(15)
        }
        
        return sectionView
    }
}

extension FormViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

