//
//  FormViewController.swift
//  FromTable
//
//  Created by mac on 17/3/9.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

enum FormCellType {
    case cash
    case month
    case text
    case image
    case city
    case telphone
}

enum FormChannelType {
    case haodai
    case shandai
}

// MARK: -

class FormViewController: UIViewController {

    // MARK: Properties
    
    var inputCommit: UserInputsCommit!
    
    public lazy var formTableView: UITableView = {
        let tb = UITableView()
        tb.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "formCell")
        tb.tableFooterView = UIView()
        tb.backgroundColor = .gray
        tb.dataSource = self
        tb.delegate = self
        tb.rowHeight = 50
        
        self.view.addSubview(tb)
        
        return tb
    }()
    
    public lazy var requestButton: UIButton = {
        let button = UIButton()
        button.setTitle("立即提交", for: .normal)
        button.backgroundColor = .blue
        
        self.view.addSubview(button)
        
        return button
    }()
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        formTableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        formTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(0, 0, 70, 0))
        }
        
        requestButton.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view).inset(UIEdgeInsetsMake(0, 15, 15, 15))
            make.top.equalTo(formTableView.snp.bottom).offset(15)
        }
    }
}

// MARK: -

extension FormViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "formCell")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension FormViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
