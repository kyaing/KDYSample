//
//  KYPlayerMaskView.swift
//  KYPlayer
//
//  Created by mac on 2017/4/26.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

public protocol PlayerMaskDelegate: NSObjectProtocol {
    
    func playerMaskViewTaped(withSlider slider: UISlider)
    
    func playerMaskViewDraging(withSlider slider: UISlider)
}

// MARK: 

class KYPlayerMaskView: UIView {
    
    // MARK: Properites
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    private var topViewLayer: CAGradientLayer!
    
    private var bottomViewLayer: CAGradientLayer!
    
    var backButton: UIButton?
    
    var lockButton: UIButton?
    
    var playButton: UIButton?
    
    var fullButton: UIButton?
    
    lazy var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        label.textColor = .white
        label.text = "00:00"
        
        return label
    }()
    
    lazy var totalTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = .white
        label.text = "00:00"
        
        return label
    }()
    
    lazy var playSlider: UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(named: "slider_thumb"), for: .normal)
        slider.addTarget(self, action: #selector(handleSliderPosition(_:)), for: .valueChanged)
        slider.minimumTrackTintColor = .white
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
        slider.minimumTrackTintColor = .red
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
    
    func setupAllViews() {
        setupTopViews()
        setupBottomViews()
    }
    
    func setupTopViews() {
        self.addSubview(topView)
    }
    
    func setupBottomViews() {
        self.addSubview(bottomView)
        self.addSubview(bufferSlider)
        self.addSubview(playSlider)
        
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(40)
        }
        
        bufferSlider.snp.makeConstraints { (make) in
            make.centerY.equalTo(bottomView)
            make.left.right.equalTo(bottomView).inset(UIEdgeInsetsMake(0, 15, 0, 15))
        }
        
        playSlider.snp.makeConstraints { (make) in
            make.edges.equalTo(bufferSlider).inset(UIEdgeInsets.zero)
        }
    }
    
    // MARK: - Event Response
    
    func handleSliderTaped(_ slider: UISlider) {
        if let delegate = maskDelegate {
            delegate.playerMaskViewTaped(withSlider: slider)
        }
    }
    
    func handleSliderPosition(_ slider: UISlider) {
        if let delegate = maskDelegate {
            delegate.playerMaskViewDraging(withSlider: slider)
        }
    }
}

