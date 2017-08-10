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
        let tb: UITableView = UITableView(frame: self.view.bounds, style: .plain)
        tb.tableFooterView = UIView()
        tb.sectionHeaderHeight = 40
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
    
    // MARK: Private Methods
    
    func getItemModel(_ indexPath: IndexPath) -> ItemModel {
        let dic   = config.getOriginalItems().object(at: indexPath.section) as! NSDictionary
        let array = dic.value(forKey: "subs") as! NSArray
        let model = array.object(at: indexPath.row) as! ItemModel
        
        return model
    }
    
    func getItemModelCount(_ section: Int) -> Int {
        let dic   = config.getOriginalItems().object(at: section) as! NSDictionary
        let array = dic.value(forKey: "subs") as! NSArray
        return array.count
    }
}

// MARK: -

extension FormViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return config.getOriginalItems().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getItemModelCount(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "formCell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "formCell")
            cell?.accessoryType = .disclosureIndicator
        }
        
        let model = getItemModel(indexPath)
        
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
        
        cell?.textLabel?.text = model.name
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionView = UIView()
        sectionView.backgroundColor = .lightGray
        
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
        
        let model = getItemModel(indexPath)
        let controller = EditTextViewController()
        controller.title = model.name
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

