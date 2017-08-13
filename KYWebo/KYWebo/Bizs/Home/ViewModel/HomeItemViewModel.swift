//
//  HomeItemViewModel.swift
//  KYWebo
//
//  Created by KYCoder on 2017/8/11.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

/// 每个Cell的viewModel
class HomeItemViewModel: NSObject {

    // MARK: - Properites
    
    var wbstatus: WbStatus?
    
    var totalHeight: CGFloat = 120  // 总高度
    
    // MARK: - Life Cycle
    
    init(withStatus status: WbStatus) {
        super.init()
        wbstatus = status
        layoutCell()
    }
    
    // MARK: - 
    
    func layoutCell() {
        
    }
}

