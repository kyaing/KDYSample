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

// PlayerItem KVO Key
private let PlayerStatusKey       = "status"
private let PlayerLoadedTimeKey   = "loadedTimeRanges"
private let PlayerEmptyBufferKey  = "playbackBufferEmpty"
private let PlayerKeepUpKey       = "playbackLikelyToKeepUp"

// Context 
private var PlayerItemContext = 0

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
    
    lazy var playerMaskView: KYPlayerMaskView = {
        let maskView = KYPlayerMaskView()
        maskView.frame = self.view.bounds
        maskView.maskDelegate = self
        
        return maskView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "http://bos.nj.bpc.baidu.com/tieba-smallvideo/11772_3c435014fb2dd9a5fd56a57cc369f6a0.mp4"
        playerItem = AVPlayerItem(url: URL(string: url)!)
        
        avplayer = AVPlayer(playerItem: playerItem)
        avPlayerLayer = AVPlayerLayer(player: avplayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspect
        avPlayerLayer.contentsScale = UIScreen.main.scale
        avPlayerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(avPlayerLayer)
        
        displayLink = CADisplayLink(target: self, selector: #selector(updateTime))
        displayLink.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
        
        addAllObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    deinit {
        removeAllObservers()
    }
    
    // MARK: - Private Methods
    
    func setupUrl(_ url: URL) {
        
    }
    
    func updateTime() {
        
    }
    
    func availableDuration() -> TimeInterval? {
        let loadedTimeRanges = playerItem.loadedTimeRanges
        
        // 获取缓冲区
        if let timeRange = loadedTimeRanges.first?.timeRangeValue {
            let bufferedTime = CMTimeGetSeconds(CMTimeAdd(timeRange.start, timeRange.duration))
            return bufferedTime
            
        } else {
            return nil
        }
    }
    
    func addAllObservers() {
        addApplicationObservers()
        addPlayerItemObservers()
    }
    
    func addApplicationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: .UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground), name: .UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground), name: .UIApplicationWillEnterForeground, object: nil)
    }
    
    func addPlayerItemObservers() {
        playerItem.addObserver(self, forKeyPath: PlayerStatusKey, options: ([.new, .old]), context: &PlayerItemContext)
        playerItem.addObserver(self, forKeyPath: PlayerLoadedTimeKey, options: ([.new, .old]), context: &PlayerItemContext)
        playerItem.addObserver(self, forKeyPath: PlayerEmptyBufferKey, options: ([.new, .old]), context: &PlayerItemContext)
        playerItem.addObserver(self, forKeyPath: PlayerKeepUpKey, options: ([.new, .old]), context: &PlayerItemContext)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidPlayToEndTime), name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemFailedToPlayToEndTime), name: .AVPlayerItemFailedToPlayToEndTime, object: playerItem)
    }
    
    func removeAllObservers() {
        NotificationCenter.default.removeObserver(self)
        removePlayerItemObservers()
    }
    
    func removePlayerItemObservers() {
        playerItem.removeObserver(self, forKeyPath: PlayerStatusKey, context: &PlayerItemContext)
        playerItem.removeObserver(self, forKeyPath: PlayerLoadedTimeKey, context: &PlayerItemContext)
        playerItem.removeObserver(self, forKeyPath: PlayerEmptyBufferKey, context: &PlayerItemContext)
        playerItem.removeObserver(self, forKeyPath: PlayerKeepUpKey, context: &PlayerItemContext)
        
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemFailedToPlayToEndTime, object: playerItem)
    }
    
    // MARK: - Event Response
    
    func applicationWillResignActive() {
        
    }
    
    func applicationDidEnterBackground() {
        
    }
    
    func applicationWillEnterForeground() {
        
    }
    
    func playerItemDidPlayToEndTime() {
        
    }
    
    func playerItemFailedToPlayToEndTime() {
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let playerItem = object as? AVPlayerItem else { return }
        
        if keyPath == PlayerLoadedTimeKey {
            // 通过监听"loadedTimeRanges"，实时知道当前视频的进度缓冲
            guard let loadedTime = availableDuration() else { return }
            
            let totalTime = CMTimeGetSeconds(playerItem.duration)
            let percent = loadedTime / totalTime
            print("precent = %ld", percent)
            
        } else if keyPath == PlayerStatusKey {
            // 只有当status为readyToPlay是调用 AVPlayer的play方法视频才能播放
            print(playerItem.status.rawValue)
            
            if playerItem.status == .readyToPlay {
                // 只有在这个状态下才能播放
                avplayer.play()
                
            } else {
                print("加载异常")
            }
        }
    }
}

// MARK: - 

extension KYPlayerViewController: PlayerMaskDelegate {
    
    func playerMaskViewTaped(withSlider slider: UISlider) {
        
    }
    
    func playerMaskViewDraging(withSlider slider: UISlider) {
        
    }
}

