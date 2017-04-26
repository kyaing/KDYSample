//
//  KYPlayerView.swift
//  KYPlayer
//
//  Created by mac on 2017/4/26.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import AVFoundation

class KYPlayerView: UIView {
    
    // MARK: Properites
    
    /// 显示层
    var playerLayer: AVPlayerLayer?
    
    /// 播放类
    var player: AVPlayer? {
        get {
            return self.playerLayer?.player
        }
        set {
            if self.playerLayer?.player != newValue {
                self.playerLayer?.player = newValue
            }
        }
    }
    
    /// 音量大小
    var volume: Float {
        get {
            return (self.player?.volume)!
        }
        set {
            self.player?.volume = newValue
        }
    }
    
    /// 显示模式
    var fillMode: String {
        get {
            return self.playerLayer?.videoGravity ?? ""
        }
        set {
            self.playerLayer?.videoGravity = newValue
        }
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

