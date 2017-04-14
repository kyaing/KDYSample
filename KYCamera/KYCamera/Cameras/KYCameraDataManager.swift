//
//  KYCameraDataManager.swift
//  KYCamera
//
//  Created by mac on 17/4/12.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import AVFoundation

/// 相机生成媒体管理类
class KYCameraDataManager: NSObject {
    
    var mediaWriter: AVAssetWriter!
    
    var videoWriterIntput: AVAssetWriterInput!
    
    var audioWriterInput: AVAssetWriterInput!
    
    var path: NSString? = nil
}

