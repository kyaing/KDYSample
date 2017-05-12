//
//  KYPlayerView.swift
//  KYPlayer
//
//  Created by mac on 2017/4/26.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

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

enum PanMoveDirection: Int, CustomStringConvertible {
    case horizontal
    case vertical
    case unknown
    
    public var description: String {
        switch self {
        case .horizontal:  return "Horizontal Direction"
        case .vertical:    return "Vertical Direction"
        case .unknown:     return "Unknown Direction"
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
    
    lazy var displayLink: CADisplayLink = {
        let displayLink = CADisplayLink(target: self, selector: #selector(updateTime))
        
        return displayLink
    }()
    
    var playbackState: PlaybackState = .stopped
    
    var bufferingState: BufferingState = .unknown
    
    var panDirection: PanMoveDirection = .unknown
    
    var speedTime: TimeInterval = 0
    
    lazy var backButton: UIButton = {
        let backBtn = UIButton()
        backBtn.backgroundColor = .clear
        backBtn.setImage(UIImage(named: "play_back_full"), for: .normal)
        backBtn.addTarget(self, action: #selector(clickBackBtnAction), for: .touchUpInside)
        
        return backBtn
    }()
    
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
    
    lazy var volumeSlider: UISlider = {
        var slider = UISlider()
        
        // 获得系统的音量控制
        let volumeView = MPVolumeView()
        for view in volumeView.subviews {
            if view.classForCoder.description() == "MPVolumeSlider" {
                slider = view as! UISlider
                break
            }
        }
        
        return slider
    }()
    
    var lastSliderValue: CGFloat = 0
    
    var isFullScreen: Bool = false
    
    var isShowMaskView: Bool = true
    
    var isVolumn: Bool = false
    
    var isDragPlayer: Bool = false
    
    weak var delegate: PlayerViewDelegate?
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 设置音频可以在iOS10下外放
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayback)
        
        setupUrl()
        setupViews()
        setupTapGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avPlayerLayer.frame = self.bounds
    }
    
    func setupViews() {
        self.addSubview(backButton)
        
        backButton.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(5)
            make.top.equalTo(self).offset(20)
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
    }
    
    func setupTapGesture() {
        let singalTap = UITapGestureRecognizer(target: self, action: #selector(singalTapMaskViewAction(_:)))
        singalTap.numberOfTapsRequired = 1
        singalTap.delegate = self
        self.addGestureRecognizer(singalTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapMaskViewAction(_:)))
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
        
        singalTap.require(toFail: doubleTap)
    }
    
    func setupPanGesture() {
        let panGesutre = UIPanGestureRecognizer(target: self, action: #selector(panMaskViewAction(_:)))
        panGesutre.delegate = self
        self.addGestureRecognizer(panGesutre)
    }
    
    func setupUrl() {
        let url = "http://bos.nj.bpc.baidu.com/tieba-smallvideo/11772_3c435014fb2dd9a5fd56a57cc369f6a0.mp4"
        playerItem = AVPlayerItem(url: URL(string: url)!)
        
        avplayer = AVPlayer(playerItem: playerItem)
        avPlayerLayer = AVPlayerLayer(player: avplayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspect
        avPlayerLayer.contentsScale = UIScreen.main.scale
        self.layer.addSublayer(avPlayerLayer)
        
        displayLink.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
        playerMaskView.activityView.startAnimating()
        
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
        
        playerMaskView.playSlider.value    = Float(currentTime / totalTime)
        playerMaskView.timeLabel.text      = formatPlayTime(seconds: currentTime)
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
        avplayer.play()
        playbackState = .playing
        playerMaskView.pauseButton.isSelected = true
    }
    
    func pausePlay() {
        avplayer.pause()
        playbackState = .paused
        playerMaskView.pauseButton.isSelected = false
    }
    
    func stopPlay() {
        
    }
    
    func seekToTime(_ time: TimeInterval) {
        if playerItem.status == .readyToPlay {
            playerMaskView.playerActivity(true)
            
            pausePlay()
            avplayer.seek(to: CMTimeMakeWithSeconds(Float64(time), Int32(NSEC_PER_SEC))) { [weak self]  _ in
                guard let strongSelf = self else { return }
                
                strongSelf.startPlay()
                strongSelf.playerMaskView.playerActivity(false)
            }
            
            resetTimer()
        }
    }
    
    func resetTimer() {
        displayLink.invalidate()
        displayLink.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
    }
    
    func showMaskView(_ isShow: Bool) {
        self.isShowMaskView = isShow
        if isShow {
            UIView.animate(withDuration: 0.45) {
                self.playerMaskView.bottomView.alpha = 1.0
            }
            
        } else {
            UIView.animate(withDuration: 0.45) {
                self.playerMaskView.bottomView.alpha = 0.0
            }
        }
    }
    
    func horizontalPanMoving(_ value: CGFloat) {
        var forward: Bool = false
        if value == 0 {
            return
        } else if value > 0 {
            forward = true
        } else {
            forward = false
        }
        
        speedTime += TimeInterval(value / 300)
        
        let totoalTime: CMTime = playerItem.duration
        let totoalTimeDuration = TimeInterval(totoalTime.value) / TimeInterval(totoalTime.timescale)
        
        if speedTime > totoalTimeDuration {
            speedTime = totoalTimeDuration
        } else if speedTime < 0 {
            speedTime = 0
        }
    
        isDragPlayer = true
        playerMaskView.playerDragTime(speedTime, totalTime: totoalTimeDuration, isForward: forward, isFullScreen: isFullScreen)
    }
    
    func verticalPanMoving(_ value: CGFloat) {
        isVolumn ? (volumeSlider.value -= Float(value / 20000)) : (UIScreen.main.brightness -= value / 20000)
    }
    
    func remarkSpeedViewOnFull() {
        playerMaskView.speedView.snapshotImage.isHidden = false
        playerMaskView.speedView.speedSlider.isHidden   = true
        
        playerMaskView.speedView.snp.remakeConstraints({ (make) in
            make.center.equalTo(self)
            make.size.equalTo(CGSize(width: 160, height: 145))
        })
    }
    
    func remakeSpeedViewOnNormal() {
        playerMaskView.speedView.speedSlider.isHidden   = false
        playerMaskView.speedView.snapshotImage.isHidden = true
        
        playerMaskView.speedView.snp.remakeConstraints({ (make) in
            make.center.equalTo(self)
            make.size.equalTo(CGSize(width: 130, height: 70))
        })
    }
    
    // MARK: - Event Response
    
    func clickBackBtnAction() {
        
    }
    
    func singalTapMaskViewAction(_ gesture: UITapGestureRecognizer) {
        showMaskView(!isShowMaskView)
    }
    
    func doubleTapMaskViewAction(_ gesture: UITapGestureRecognizer) {
        if playbackState == .paused {
            startPlay()
        } else if playbackState == .playing {
            pausePlay()
        }
    }
    
    func panMaskViewAction(_ gesture: UIPanGestureRecognizer) {
        let locationPoint = gesture.location(in: self)
        let veloctyPoint  = gesture.velocity(in: self)
        
        switch gesture.state {
        case .began:
            let xPos = fabs(veloctyPoint.x)
            let yPos = fabs(veloctyPoint.y)
            
            if xPos > yPos {
                panDirection = .horizontal
                let time: CMTime = avplayer.currentTime()
                speedTime = TimeInterval(time.value) / TimeInterval(time.timescale)
                
            } else if xPos < yPos {
                panDirection = .vertical
                if locationPoint.x < self.width / 2.0 {
                    isVolumn = false
                } else {
                    isVolumn = true
                }
            }
        
        case .changed:
            if panDirection == .horizontal {
                horizontalPanMoving(veloctyPoint.x)
            } else {
                verticalPanMoving(veloctyPoint.y)
            }
            
        case .ended:
            if panDirection == .horizontal {
                seekToTime(speedTime)
            } else {
                isVolumn = false
            }
            
        default: break
        }
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
            if playerItem.status == .readyToPlay {
                // 在这个状态下才能播放
                bufferingState = .ready
                
                // 添加Pan手势
                setupPanGesture()
                
            } else {
                bufferingState = .unknown
            }
            playbackState = .paused
            
        } else if keyPath == PlayerEmptyBufferKey {
            bufferingState = .delayed
            if !playerMaskView.activityView.isAnimating {
                playerMaskView.activityView.startAnimating()
            }
        
        } else if keyPath == PlayerKeepUpKey {
            playerMaskView.activityView.stopAnimating()
            
        } else if keyPath == PlayerRateKey {
            
        }
    }
}

// MARK:

extension KYPlayerView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isKind(of: UISlider.classForCoder()))! {
            return false
        }
        
        return true
    }
}

// MARK:

extension KYPlayerView: PlayerMaskViewDelegate {
    
    func handlePlayPauseButton(_ button: UIButton) {
        if bufferingState == .ready {
            if playbackState == .paused {
                startPlay()
                
            } else if playbackState == .playing {
                pausePlay()
            }
        }
    }
    
    func handleFullscreenButton(_ button: UIButton) {
        if let delegate = delegate {
            delegate.handleFullscreenAction()
        }
        
        button.isSelected = !button.isSelected
        isFullScreen = button.isSelected
        
        // 改变全屏下SpeedView的布局
        // isFullScreen ? remarkSpeedViewOnFull() : remakeSpeedViewOnNormal()
        
        if isFullScreen {
            playerMaskView.speedView.snp.remakeConstraints({ (make) in
                make.top.equalTo(self).offset(120)
                make.centerX.equalTo(self)
                make.size.equalTo(CGSize(width: 130, height: 70))
            })
        } else {
            playerMaskView.speedView.snp.remakeConstraints({ (make) in
                make.center.equalTo(self)
                make.size.equalTo(CGSize(width: 130, height: 70))
            })
        }
    }
    
    func playerMaskTaped(withSlider slider: UISlider) {
        
    }
    
    func playerMaskDraging(withSlider slider: UISlider) {
        if playerItem.status == .readyToPlay {
            resetTimer()
            
            isDragPlayer = true
            
            let totalTime = CGFloat(playerItem.duration.value) / CGFloat(playerItem.duration.timescale)
            let seconds = totalTime * CGFloat(slider.value)
            
            let value = CGFloat(slider.value) - lastSliderValue
            var forward: Bool
            if (value > 0) {
                forward = true
            } else if value < 0 {
                forward = false
            } else {
                return
            }
            lastSliderValue = CGFloat(slider.value)
            
            playerMaskView.playerDragTime(TimeInterval(seconds), totalTime: TimeInterval(totalTime), isForward: forward, isFullScreen: isFullScreen)
        }
    }

    func playerMaskEnd(withSlider slider: UISlider) {
        if playerItem.status == .readyToPlay {
            isDragPlayer = false
            
            let totalTime = CGFloat(playerItem.duration.value) / CGFloat(playerItem.duration.timescale)
            let seconds = totalTime * CGFloat(slider.value)
            
            var time = max(0, seconds)
            time = min(seconds, totalTime)
            
            seekToTime(TimeInterval(time))
            
        } else {
            slider.value = 0
        }
    }
}

