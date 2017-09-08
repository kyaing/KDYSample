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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let model = dataSource[indexPath.row] as! ConversationModel
            
            let alertController = UIAlertController(title: "删除将清空该聊天的消息记录", message: nil, preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "删除", style: .destructive, handler: { (alert) in
                // 删除数据源
                EMClient.shared().chatManager.deleteConversation(model.conversation.conversationId, isDeleteMessages: true, completion: nil)
                self.dataSource.removeObject(at: indexPath.row)
                
                tableView.deleteRows(at: [indexPath], with: .top)
                
                // 更新未读消息数
                let unReadCounts = Int(model.conversation.unreadMessagesCount)
                var badgeNumber = UIApplication.shared.applicationIconBadgeNumber
                badgeNumber -= unReadCounts
                
                if badgeNumber > 0 {
                    UIApplication.shared.applicationIconBadgeNumber = badgeNumber
                    self.tabBarItem.badgeValue = String(format: "%d", badgeNumber)
                    
                } else {
                    UIApplication.shared.applicationIconBadgeNumber = 0
                    self.tabBarItem.badgeValue = nil
                }
            }))
            
            alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDelegate

extension KYConversationController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - EMChatManagerDelegate

extension KYConversationController: EMChatManagerDelegate {
    
}

