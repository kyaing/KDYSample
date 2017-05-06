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

class KYPlayerViewController: UIViewController {

    // MARK: Properites
    
    var url: URL? {
        didSet {
            
        }
    }
    
    lazy var playerView: KYPlayerView = {
        let playerView = KYPlayerView()
        playerView.delegate = self
        self.view.addSubview(playerView)
        
        playerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.left.right.equalTo(self.view)
            make.height.equalTo(playerView.snp.width).multipliedBy(9.0/16.0)
        }
        
        return playerView
    }()
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "播放器"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.playerView.backgroundColor = .black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func interfaceOrientation(_ oriendtaion: UIDeviceOrientation) {
        
        if oriendtaion == .portrait {
            self.playerView.removeFromSuperview()
            self.view.addSubview(self.playerView)
            self.playerView.snp.remakeConstraints({ (make) in
                make.top.equalTo(self.view)
                make.left.right.equalTo(self.view)
                make.height.equalTo(playerView.snp.width).multipliedBy(9.0/16.0)
            })
            
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.35)
            self.playerView.transform = CGAffineTransform.identity
            self.refreshStatusBarOrientation(.portrait)
            self.playerView.isFullScreen = false
            UIView.commitAnimations()
            
        } else {
            self.playerView.removeFromSuperview()
            UIApplication.shared.keyWindow?.addSubview(self.playerView)
            self.playerView.snp.remakeConstraints({ (make) in
                make.width.equalTo(self.view.height)
                make.height.equalTo(self.view.width)
                make.center.equalTo(UIApplication.shared.keyWindow!)
            })
            
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.35)
            self.playerView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
            self.refreshStatusBarOrientation(.landscapeRight)
            self.playerView.isFullScreen = true
            UIView.commitAnimations()
        }
    }
    
    func refreshStatusBarOrientation(_ oriendtaion: UIInterfaceOrientation) {
        UIApplication.shared.setStatusBarOrientation(oriendtaion, animated: true)
    }
    
    deinit {
        
    }
}

// MARK:

extension KYPlayerViewController: PlayerViewDelegate {
    
    func handlePlayPauseButton(_ button: UIButton) {
        if playerView.bufferingState == .ready {
            if button.isSelected {
                playerView.avplayer.pause()
            } else {
                playerView.avplayer.play()
                
                // 5秒后，隐藏遮罩视图
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    
                })
            }
            
            button.isSelected = !button.isSelected
        }
    }
    
    func handleFullscreenButton(_ button: UIButton) {
        button.isSelected = !button.isSelected
        
        if playerView.isFullScreen {
            interfaceOrientation(.portrait)
        } else {
            interfaceOrientation(.landscapeRight)
        }
    }
    
    func playerMaskTaped(withSlider slider: UISlider) {
        
    }
    
    func playerMaskDraging(withSlider slider: UISlider) {
        
    }
}

