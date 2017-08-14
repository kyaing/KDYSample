//
//  HomeTimelineCell.swift
//  KYWebo
//
//  Created by kaideyi on 2017/8/12.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class HomeTimelineCell: UITableViewCell {
    
    lazy var statusView: WbStatusView = {
        let stauts = WbStatusView()
        stauts.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 1)
        
        return stauts
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.contentView.addSubview(statusView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout
    
    func setupCell(withViewmodel viewModel: HomeItemViewModel) {
        self.height = viewModel.totalHeight
        self.contentView.height = viewModel.totalHeight
        
        statusView.setupStatus(withViewmodel: viewModel)
    }
}

