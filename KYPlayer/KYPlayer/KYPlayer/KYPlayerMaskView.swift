//
//  KYPlayerMaskView.swift
//  KYPlayer
//
//  Created by mac on 2017/4/26.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

public protocol PlayerMaskDelegate: NSObjectProtocol {
    
    func playerMaskTaped(withSlider slider: UISlider)
    
    func playerMaskDraging(withSlider slider: UISlider)
}

// MARK: 

class KYPlayerMaskView: UIView {
    
    // MARK: Properites
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    var backButton: UIButton?
    
    var lockButton: UIButton?
    
    lazy var playButton: UIButton = {
        let playBtn = UIButton()
        playBtn.setImage(UIImage(named: "player_pause"), for: .normal)
        playBtn.setImage(UIImage(named: "player_play"), for: .selected)
        playBtn.setImage(UIImage(named: "player_play"), for: .highlighted)
        playBtn.addTarget(self, action: #selector(clickPlayOrPauseBtnAction(_:)), for: .touchUpInside)
        
        return playBtn
    }()
    
    lazy var fullButton: UIButton = {
        let fullBtn = UIButton()
        fullBtn.setImage(UIImage(named: "player_fullscreen"), for: .normal)
        fullBtn.setImage(UIImage(named: "player_shrinkscreen"), for: .selected)
        fullBtn.setImage(UIImage(named: "player_shrinkscreen"), for: .highlighted)
        fullBtn.addTarget(self, action: #selector(clickPlayOrPauseBtnAction(_:)), for: .touchUpInside)
        
        return fullBtn
    }()
    
    var isFullScreen: Bool = false {
        didSet {
            
        }
    }
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        label.textColor = .white
        
        return label
    }()
    
    lazy var totalTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = .white
        
        return label
    }()
    
    lazy var playSlider: UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(named: "slider_thumb"), for: .normal)
        slider.addTarget(self, action: #selector(handleSliderPosition(_:)), for: .valueChanged)
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .clear
        slider.maximumValue = 1.0
        slider.minimumValue = 0.0
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSliderTaped(_:)))
        slider.addGestureRecognizer(tapGesture)
    
        return slider
    }()
    
    lazy var bufferSlider: UISlider = {
        let slider = UISlider()
        slider.isUserInteractionEnabled = false
        slider.setThumbImage(UIImage(), for: .normal)
        slider.minimumTrackTintColor = .white
        slider.maximumValue = 1.0
        slider.minimumValue = 0.0
        
        return slider
    }()
    
    weak var maskDelegate: PlayerMaskDelegate?
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAllViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupAllViews() {
        setupTopViews()
        setupBottomViews()
    }
    
    func setupTopViews() {
        self.addSubview(topView)
    }
    
    func setupBottomViews() {
        self.addSubview(bottomView)
        
        bottomView.addSubview(timeLabel)
        bottomView.addSubview(totalTimeLabel)
        bottomView.addSubview(playButton)
        bottomView.addSubview(fullButton)
        bottomView.addSubview(bufferSlider)
        bottomView.addSubview(playSlider)
        
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(40)
        }
        
        playButton.snp.makeConstraints { (make) in
            make.left.equalTo(bottomView).offset(5)
            make.centerY.equalTo(bottomView)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        fullButton.snp.makeConstraints { (make) in
            make.right.equalTo(bottomView).offset(-5)
            make.centerY.equalTo(bottomView)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(playButton.snp.right).offset(5)
            make.centerY.equalTo(bottomView)
            make.width.equalTo(35)
        }
        
        totalTimeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(fullButton.snp.left).offset(-5)
            make.centerY.equalTo(bottomView)
            make.width.equalTo(35)
        }
        
        bufferSlider.snp.makeConstraints { (make) in
            make.centerY.equalTo(bottomView)
            make.left.equalTo(timeLabel.snp.right).offset(8)
            make.right.equalTo(totalTimeLabel.snp.left).offset(-8)
        }
        
        playSlider.snp.makeConstraints { (make) in
            make.edges.equalTo(bufferSlider)
        }
    }
    
    // MARK: - Event Response
    
    func handleSliderTaped(_ slider: UISlider) {
        if let delegate = maskDelegate {
            delegate.playerMaskTaped(withSlider: slider)
        }
    }
    
    func handleSliderPosition(_ slider: UISlider) {
        if let delegate = maskDelegate {
            delegate.playerMaskDraging(withSlider: slider)
        }
    }
    
    func clickPlayOrPauseBtnAction(_ button: UIButton) {
        
    }
    
    func clickFullScreenOrNotBtnAction(_ button: UIButton) {
        
    }
}

