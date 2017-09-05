//
//  KYConversationController+Delegate.swift
//  KYChat
//
//  Created by KYCoder on 2017/9/5.
//  Copyright © 2017年 mac. All rights reserved.
//

import Foundation

// MARK: - UITableViewDataSource

extension KYConversationController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ConversationCell = tableView.dequeueReusableCell(for: indexPath)
        cell.model = dataSource[indexPath.row] as! ConversationModel
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension KYConversationController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

