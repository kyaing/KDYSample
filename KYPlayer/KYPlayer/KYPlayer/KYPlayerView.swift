//
//  KYPlayerView.swift
//  KYPlayer
//
//  Created by mac on 2017/4/26.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import AVFoundation

// PlayerItem KVO Key
private let PlayerStatusKey       = "status"
private let PlayerLoadedTimeKey   = "loadedTimeRanges"
private let PlayerEmptyBufferKey  = "playbackBufferEmpty"
private let PlayerKeepUpKey       = "playbackLikelyToKeepUp"

// AVPlayer KVO Key
private let PlayerRateKey = "rate"

// Context
private var PlayerItemContext = 0
private var PlayerContext = 0

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

class KYPlayerView: UIView {
    
    // MARK: Properites
    
    var videoUrl: URL?
    
    var volume: Float?
    
    var fillMode: String?
    
    var playerItem: AVPlayerItem!
    
    var avplayer: AVPlayer!
    
    var avPlayerLayer: AVPlayerLayer!
    
    var displayLink: CADisplayLink!
    
    var playbackState: PlaybackState = .stopped {
        willSet {
        }
    }
    
    var bufferingState: BufferingState = .unknown {
        willSet {
        }
    }
    
    lazy var playerMaskView: KYPlayerMaskView = {
        let maskView = KYPlayerMaskView()
        maskView.backgroundColor = .clear
        maskView.maskDelegate = self as? PlayerMaskDelegate
        
        return maskView
    }()
    
    var isFullScreen: Bool = false
    
    var isShowMaskView: Bool = true
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 设置音频可以在iOS10下外放
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayback)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideMaskView))
        self.addGestureRecognizer(tapGesture)
        
        setupUrl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avPlayerLayer.frame = self.bounds
    }
    
    func setupUrl() {
        let url = "http://bos.nj.bpc.baidu.com/tieba-smallvideo/11772_3c435014fb2dd9a5fd56a57cc369f6a0.mp4"
        playerItem = AVPlayerItem(url: URL(string: url)!)
        
        avplayer = AVPlayer(playerItem: playerItem)
        avPlayerLayer = AVPlayerLayer(player: avplayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspect
        avPlayerLayer.contentsScale = UIScreen.main.scale
        self.layer.addSublayer(avPlayerLayer)
        
        displayLink = CADisplayLink(target: self, selector: #selector(updateTime))
        displayLink.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
        
        // 遮罩视图
        self.addSubview(playerMaskView)
        playerMaskView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        addAllObservers()
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
    
    func addPlayerObservers() {
        avplayer.addObserver(self, forKeyPath: PlayerRateKey, options: ([.new, .old]), context: &PlayerContext)
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
    
    func removerPlayerObservers() {
        avplayer.removeObserver(self, forKeyPath: PlayerRateKey, context: &PlayerContext)
    }
    
    // MARK: - Private Methods
    
    func formatPlayTime(seconds: TimeInterval) -> String {
        if seconds.isNaN {
            return "00:00"
        }
        
        let min = Int(seconds / 60)
        let sec = Int(seconds.truncatingRemainder(dividingBy: 60))  // Swift3.x之后的求余计算
        
        if min >= 100 {
            return String(format: "%03d:%02d", min, sec)
        }
        
        return String(format: "%02d:%02d", min, sec)
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
    
    // MARK: - Event Response
    
    func updateTime() {
        let currentTime = CMTimeGetSeconds(playerItem.currentTime())
        let totalTime = TimeInterval(playerItem.duration.value) / TimeInterval(playerItem.duration.timescale)
        
        playerMaskView.playSlider.value = Float(currentTime / totalTime)
        
        playerMaskView.timeLabel.text = formatPlayTime(seconds: currentTime)
        playerMaskView.totalTimeLabel.text = formatPlayTime(seconds: totalTime)
    }
    
    func hideMaskView() {
        if isShowMaskView {
            UIView.animate(withDuration: 0.45, animations: {
                self.playerMaskView.alpha = 0
            }, completion: { (finished) in
                self.isShowMaskView = false
            })
            
        } else {
            UIView.animate(withDuration: 0.45, animations: {
                self.playerMaskView.alpha = 1.0
            }, completion: { (finished) in
                self.isShowMaskView = true
            })
        }
    }
    
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
            // 实时监听当前视频的进度缓冲
            guard let loadedTime = availableDuration() else { return }
            
            let totalTime = CMTimeGetSeconds(playerItem.duration)
            let percent = loadedTime / totalTime
            playerMaskView.bufferSlider.value = Float(percent)
            
        } else if keyPath == PlayerStatusKey {
            // 只有当status为readyToPlay是调用 AVPlayer的play方法视频才能播放
            print(playerItem.status.rawValue)
            
            if playerItem.status == .readyToPlay {
                // 在这个状态下才能播放
                // avplayer.play()
                bufferingState = .ready
                
            } else {
                print("加载异常")
                bufferingState = .unknown
            }
            
        } else if keyPath == PlayerRateKey {
            
        }
    }
}

