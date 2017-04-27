//
//  KYPlayerViewController.swift
//  KYPlayer
//
//  Created by mac on 2017/4/26.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import AVFoundation

// Audio, Video
// AVPlayerItem, AVPlayer, AVPlayerLayer

/// 显示模式
public enum FillMode: String {
    case resize           = "AVLayerVideoGravityResize"
    case resizeAspect     = "AVLayerVideoGravityResizeAspect"
    case resizeAspectFill = "AVLayerVideoGravityResizeAspectFill"
}

/// 播放状态
public enum PlaybackState: Int, CustomStringConvertible {
    case playing = 0
    case paused
    case stopped
    case failed
    
    public var description: String {
        switch self {
            case .playing: return "Playing"
            case .paused:  return "Paused"
            case .stopped: return "Stoped"
            case .failed:  return "Failed"
        }
    }
}

/// 缓冲状态
public enum BufferingState: Int, CustomStringConvertible {
    case ready = 0
    case delayed
    case unknown
    
    public var description: String {
        switch self {
            case .ready:   return "Buffering Ready"
            case .delayed: return "Buffering Delayed"
            case .unknown: return "Buffering Unknown"
        }
    }
}

// MARK:

class KYPlayerViewController: UIViewController {

    // MARK: Properites
    
    var url: URL? {
        didSet {
        }
    }
    
    var playbackState: PlaybackState = .stopped {
        didSet {
        }
    }
    
    var bufferingState: BufferingState = .unknown {
        didSet {
            
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    deinit {
    }
    
    // MARK: - Private Methods
}

