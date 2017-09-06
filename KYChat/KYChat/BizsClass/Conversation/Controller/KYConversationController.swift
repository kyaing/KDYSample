//
//  KYConversationController.swift
//  KYChat
//
//  Created by KYCoder on 2017/8/30.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import SnapKit

class KYConversationController: UIViewController {
   
    lazy var searchController: UISearchController = {
        let search: UISearchController = UISearchController(searchResultsController: nil)
        search.dimsBackgroundDuringPresentation = false
        search.searchBar.tintColor = KYColor.ChatGreen.color
        search.searchBar.sizeToFit()
        
        return search
    }()
    
    lazy var tableView: UITableView = {
        let tb: UITableView = UITableView(frame: CGRect.zero, style: .plain)
        tb.backgroundColor = KYColor.TableBackground.color
        tb.separatorColor  = KYColor.Separator.color
        tb.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        tb.register(cellType: ConversationCell.self)
        tb.tableHeaderView = self.searchController.searchBar
        tb.tableFooterView = UIView()
        tb.dataSource = self
        tb.delegate = self
        tb.rowHeight = 65
        
        return tb
    }()

    var dataSource = NSMutableArray()
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        networkIsConnected()
        registerChatDelegate()
    }
    
    deinit {
        removeChatDelegate()
    }
    
    // MARK: - Public Methods
    
    func setupSubViews() {
        let rightBarItem = UIBarButtonItem(image: KYAsset.AddFriends.image, style: .plain,
                                           target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = rightBarItem
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    func refreshConversations() {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            
            if let conversations = EMClient.shared().chatManager.getAllConversations() {
                let conversations = conversations as NSArray
                if conversations.count == 0 { return }
                
                conversations.enumerateObjects({ (emConversation, idx, stop) in
                    let conversation = (emConversation as! EMConversation)
                    if conversation.latestMessage == nil {
                        // 当消息为空则删除
                        EMClient.shared().chatManager.deleteConversation(conversation.conversationId,
                                                                         isDeleteMessages: true, completion: nil)
                    }
                })
                
                // 降序排列会话
                let sortedConversations: [EMConversation] = conversations.sortedArray(comparator:
                { (obj1, obj2) -> ComparisonResult in
                    let conversation1 = obj1 as? EMConversation
                    let conversation2 = obj2 as? EMConversation
                    
                    if let conver1 = conversation1, let conver2 = conversation2 {
                        if conver1.latestMessage.timestamp > conver2.latestMessage.timestamp {
                            return .orderedAscending
                        } else {
                            return .orderedDescending
                        }
                    }
                    return .orderedSame
                    
                }) as! [EMConversation]
                
                // 处理数据源
                self.dataSource.removeAllObjects()
                for conversation in sortedConversations {
                    let model = ConversationModel(conversation: conversation)
                    self.dataSource.add(model)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func registerChatDelegate() {
        EMClient.shared().chatManager.add(self, delegateQueue: nil)
    }
    
    func removeChatDelegate() {
        EMClient.shared().chatManager.remove(self)
    }
    
    func networkIsConnected() {
        
    }
    
    func networkStateChangede(_ state: EMConnectionState) {
        if state == EMConnectionDisconnected {
            
        } else if state == EMConnectionConnected {
            
        }
    }
}



