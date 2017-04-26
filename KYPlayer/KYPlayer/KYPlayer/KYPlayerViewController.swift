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
            setupUrl(url!)
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
    
    var playerItem: AVPlayerItem!
    
    var avplayer: AVPlayer!
    
    var avPlayerLayer: AVPlayerLayer!
    
    var displayLink: CADisplayLink!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "http://bos.nj.bpc.baidu.com/tieba-smallvideo/11772_3c435014fb2dd9a5fd56a57cc369f6a0.mp4"
        playerItem = AVPlayerItem(url: URL(string: url)!)
        
        playerItem.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        playerItem.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        
        avplayer = AVPlayer(playerItem: playerItem)
        avPlayerLayer = AVPlayerLayer(player: avplayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspect
        avPlayerLayer.contentsScale = UIScreen.main.scale
        avPlayerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(avPlayerLayer)
        
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    deinit {
        playerItem.removeObserver(self, forKeyPath: "loadedTimeRanges")
        playerItem.removeObserver(self, forKeyPath: "status")
    }
    
    // MARK: - Event Response 
    
    
    // MARK: - Private Methods
    
    func setupUrl(_ url: URL) {
        
    }
    
    func update() {
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let playerItem = object as? AVPlayerItem else { return }
        
        if keyPath == "loadedTimeRanges"{
            // 通过监听AVPlayerItem的"loadedTimeRanges"，可以实时知道当前视频的进度缓冲
            //            let loadedTime = avalableDurationWithplayerItem()
            //            let totalTime = CMTimeGetSeconds(playerItem.duration)
            //            let percent = loadedTime/totalTime
            
        } else if keyPath == "status"{
            // AVPlayerItemStatusUnknown,AVPlayerItemStatusReadyToPlay, AVPlayerItemStatusFailed。只有当status为AVPlayerItemStatusReadyToPlay是调用 AVPlayer的play方法视频才能播放。
            print(playerItem.status.rawValue)
            
            if playerItem.status == AVPlayerItemStatus.readyToPlay {
                // 只有在这个状态下才能播放
                avplayer.play()
                
            } else {
                print("加载异常")
            }
        }
    }
}

