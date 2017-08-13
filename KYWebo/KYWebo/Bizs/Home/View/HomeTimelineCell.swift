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
        return stauts
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(statusView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods
    
    func setupCell(withViewmodel viewModel: HomeItemViewModel) {
        self.height = viewModel.totalHeight
        self.contentView.height = viewModel.totalHeight
        
        statusView.setupStatus(withViewmodel: viewModel)
    }
}

