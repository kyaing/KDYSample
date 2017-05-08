//
//  KYPlayerSpeedView.swift
//  KYPlayer
//
//  Created by mac on 2017/5/8.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

/// 快进视图
class KYPlayerSpeedView: UIView {
    
    // MARK: - Properties
    
    lazy var timeLabel: UILabel = {
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
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "/"
        label.sizeToFit()
        
        return label
    }()
    
    lazy var speedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "fast_forward")
        
        return imageView
    }()
    
    lazy var speedSlider: UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(), for: .normal)
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .clear
        slider.maximumValue = 1.0
        slider.minimumValue = 0.0
        slider.value = 0.5
        
        return slider
    }()

    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(white: 0.1, alpha: 0.8)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(speedImageView)
        self.addSubview(label)
        self.addSubview(timeLabel)
        self.addSubview(totalTimeLabel)
        self.addSubview(speedSlider)
        
        speedImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(5)
            make.centerX.equalTo(self)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        label.snp.makeConstraints { (make) in
            make.top.equalTo(speedImageView.snp.bottom)
            make.centerX.equalTo(self)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(label.snp.left).offset(-2)
            make.centerY.equalTo(label)
        }
        
        totalTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(label.snp.right).offset(2)
            make.centerY.equalTo(label)
        }
        
        speedSlider.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.left.right.bottom.equalTo(self).inset(UIEdgeInsetsMake(0, 10, 10, 10))
        }
    }
}

