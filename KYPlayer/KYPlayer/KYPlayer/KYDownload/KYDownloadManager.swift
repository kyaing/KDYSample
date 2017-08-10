//
//  KYDownloadManager.swift
//  KYPlayer
//
//  Created by kaideyi on 2017/5/13.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

/**
 * 文件下载管理类
 * (支持的主要功能：文件存取、后台下载、断点续传等)
 */

class KYDownloadManager: NSObject {
    
    // MARK: - Properties
    
    static let `default` = KYDownloadManager()
    
    // MARK: - Life Cycle
    
    fileprivate override init() {
        super.init()
    }
}

