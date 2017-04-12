//
//  KYCameraViewController.swift
//  KYCamera
//
//  Created by mac on 17/4/12.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import AVFoundation

/**
 *  自定义相机实现的功能，可以拍照，可以录制.
 */

/// 自定义相机类
class KYCameraViewController: UIViewController {

    // MARK: - Properites
    
    lazy var settingView: CameraSettingView = {
        let setting = CameraSettingView()
        setting.backgroundColor = .gray
        
        return setting
    }()

    lazy var previewView: CameraPreviewView = {
        let preview = CameraPreviewView()
        preview.backgroundColor = .white
        
        return preview
    }()
    
    /// 预览图层
    lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let captureSession = AVCaptureSession()
        let previewLayer = AVCaptureVideoPreviewLayer(session: self.cameraManger.captureSession)
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        return previewLayer!
    }()
    
    lazy var recorderView: CameraRecorderView = {
        let recorder = CameraRecorderView()
        recorder.backgroundColor = .gray
        
        return recorder
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    lazy var cameraManger: KYCameraManager = {
        return KYCameraManager()
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupChildViews()
        cameraManger.startCaptureSession()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Private Methods
    
    func setupChildViews() {
        self.view.addSubview(settingView)
        self.view.addSubview(previewView)
        self.view.addSubview(recorderView)
        
        settingView.backColosure = {
            _ = self.navigationController?.popViewController(animated: true)
        }
        
        previewLayer.frame = self.view.bounds;
        previewLayer.backgroundColor = UIColor.red.cgColor
        self.view.layer.insertSublayer(previewLayer, at: 0)
        
//        settingView.snp.makeConstraints { (make) in
//            make.left.top.right.equalTo(self.view)
//            make.height.equalTo(44)
//        }
//        
//        previewView.snp.makeConstraints { (make) in
//            make.left.right.equalTo(self.view)
//            make.top.equalTo(settingView.snp.bottom)
//            make.bottom.equalTo(recorderView.snp.top)
//        }
//        
//        recorderView.snp.makeConstraints { (make) in
//            make.left.bottom.right.equalTo(self.view)
//            make.height.equalTo(100)
//        }
    }
}

