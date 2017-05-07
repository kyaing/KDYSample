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

public protocol PlayerViewDelegate: NSObjectProtocol {
    
    func handleFullscreenAction()
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
    
    var playbackState: PlaybackState = .stopped
    
    var bufferingState: BufferingState = .unknown
    
    lazy var playerMaskView: KYPlayerMaskView = {
        let maskView = KYPlayerMaskView()
        maskView.maskDelegate = self
        self.addSubview(maskView)
        
        maskView.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
        })
        
        return maskView
    }()
    
    lazy var rateSlider: UISlider = {
        let slider = UISlider()
        slider.isUserInteractionEnabled = false
        slider.setThumbImage(UIImage(), for: .normal)
        slider.minimumTrackTintColor = .red
        slider.maximumValue = 1.0
        slider.minimumValue = 0.0
        
        return slider
    }()
    
    var isFullScreen: Bool = false
    
    weak var delegate: PlayerViewDelegate?
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 设置音频可以在iOS10下外放
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayback)
        
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
    
    func updateTime() {
        let currentTime = CMTimeGetSeconds(playerItem.currentTime())
        let totalTime = TimeInterval(playerItem.duration.value) / TimeInterval(playerItem.duration.timescale)
        
        playerMaskView.playSlider.value = Float(currentTime / totalTime)
        
        playerMaskView.timeLabel.text = formatPlayTime(seconds: currentTime)
        playerMaskView.totalTimeLabel.text = formatPlayTime(seconds: totalTime)
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
    
    func startPlay() {
        
    }
    
    func pausePlay() {
        
    }
    
    func stopPlay() {
        
    }
    
    func seekToTime(_ seconds: CGFloat) {
        
    }
    
    func resetTimer() {
        displayLink.invalidate()
        displayLink = nil
        
        displayLink = CADisplayLink(target: self, selector: #selector(updateTime))
        displayLink.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
    }
    
    // MARK: - Event Response
    
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
            if playerItem.status == .readyToPlay {
                // 在这个状态下才能播放
                bufferingState = .ready
                
            } else {
                print("加载异常")
                bufferingState = .unknown
            }
            
        } else if keyPath == PlayerRateKey {
            
        }
    }
}

// MARK:

extension KYPlayerView: PlayerMaskViewDelegate {
    
    func handlePlayPauseButton(_ button: UIButton) {
        if self.bufferingState == .ready {
            if button.isSelected {
                avplayer.pause()
            } else {
                avplayer.play()
                
                // 5秒后，隐藏遮罩视图
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    
                })
            }
            
            button.isSelected = !button.isSelected
        }
    }
    
    func handleFullscreenButton(_ button: UIButton) {
        button.isSelected = !button.isSelected

        if let delegate = delegate {
            delegate.handleFullscreenAction()
        }
    }
    
    func playerMaskTaped(withSlider slider: UISlider) {
        
    }
    
    func playerMaskDraging(withSlider slider: UISlider) {
        displayLink.invalidate()
    }

    func playerMaskEnd(withSlider slider: UISlider) {
        let totalTime = CGFloat(playerItem.duration.value) / CGFloat(playerItem.duration.timescale)
        let seconds = totalTime * CGFloat(slider.value)
        
        var time = max(0, seconds)
        time = min(seconds, totalTime)
        
        avplayer.pause()
        avplayer.seek(to: CMTimeMakeWithSeconds(Float64(time), Int32(NSEC_PER_SEC))) { _ in
            self.avplayer.play()
        }
        
        resetTimer()
    }
}

