//
//  KYCameraManager.swift
//  KYCamera
//
//  Created by mac on 17/4/12.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import AVFoundation

/// 相机拍摄管理类
class KYCameraManager: NSObject {
    
    // MARK: - Properties
    
    /// 输入与输出会话
    lazy var captureSession: AVCaptureSession = {
        let session = AVCaptureSession()
        
        // 设置分辨率
        if session.canSetSessionPreset(AVCaptureSessionPreset1280x720) {
            session.sessionPreset = AVCaptureSessionPreset1280x720
        }
        
        return session
    }()
    
    /// 照片流输出
    lazy var imageOutput: AVCaptureStillImageOutput = {
        let imageOutput = AVCaptureStillImageOutput()
        imageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        
        return imageOutput
    }()
    
    /// 后置摄像头输入
    lazy var backCameraInput: AVCaptureDeviceInput? = {
        do {
            let backCameraInput = try AVCaptureDeviceInput(device: self.getCameraDevice(withPosition: .back))
            return backCameraInput
            
        } catch {
            print("获取后置摄像头失败！")
            return nil
        }
    }()
    
    /// 前置摄像头输入
    lazy var frontCameraInput: AVCaptureDeviceInput? = {
        do {
            let frontCameraInput = try AVCaptureDeviceInput(device: self.getCameraDevice(withPosition: .front))
            return frontCameraInput

        } catch {
            print("获取前置摄像头失败！")
            return nil
        }
    }()
    
    /// 音频输入
    lazy var audioInput: AVCaptureDeviceInput? = {
        let audioDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio)

        do {
            let audioInput = try AVCaptureDeviceInput(device: audioDevice)
            return audioInput
            
        } catch {
            print("获取麦克风失败！")
            return nil
        }
    }()
    
    let captureQueue = DispatchQueue(label: "kaideyi.com.KYCamera")
    
    /// 视频输出
    lazy var videoOutput: AVCaptureVideoDataOutput = {
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: self.captureQueue)
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable: NSNumber(value: kCVPixelFormatType_32BGRA)]
        
        return videoOutput
    }()
    
    /// 音频输出
    lazy var audioOutput: AVCaptureAudioDataOutput = {
        let audioOutput = AVCaptureAudioDataOutput()
        audioOutput.setSampleBufferDelegate(self, queue: self.captureQueue)
        
        return audioOutput
    }()
    
    /// 预览图层
    lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let captureSession = AVCaptureSession()
        let previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        return previewLayer!
    }()
    
    /// 图片连接
    lazy var imageConnection: AVCaptureConnection = {
        let connection = AVCaptureConnection()
        return connection
    }()
    
    /// 视频连接
    lazy var videoConnection: AVCaptureConnection = {
        let connection = AVCaptureConnection()
        return connection
    }()
    
    /// 音频连接
    lazy var audioConnection: AVCaptureConnection = {
        let connection = AVCaptureConnection()
        return connection
    }()
    
    // MARK: - Public Methods
    
    func startCaptureSession() {
        setupSessionInputs()
        setupSessionOutputs()
        
        if !captureSession.isRunning {
            captureSession.startRunning()
        }
    }
    
    func stopCaptureSession() {
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
    
    // 添加输入设备
    func setupSessionInputs() {
        if captureSession.canAddInput(audioInput) {
            captureSession.addInput(audioInput)
        }
        
        if captureSession.canAddInput(backCameraInput) {
            captureSession.addInput(backCameraInput)
        }
        
        if captureSession.canAddInput(frontCameraInput) {
            captureSession.addInput(frontCameraInput)
        }
    }
    
    // 添加输出设备
    func setupSessionOutputs() {
        if captureSession.canAddOutput(imageOutput) {
            captureSession.addOutput(imageOutput)
        }
        imageConnection = imageOutput.connection(withMediaType: AVMediaTypeVideo)
        
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        }
        videoConnection = videoOutput.connection(withMediaType: AVMediaTypeVideo)
        videoConnection.videoOrientation = .portrait
        
        if captureSession.canAddOutput(audioOutput) {
            captureSession.addOutput(audioOutput)
        }
        audioConnection = audioOutput.connection(withMediaType: AVMediaTypeAudio)
    }
    
    // 获取指定的摄像头
    func getCameraDevice(withPosition position: AVCaptureDevicePosition) -> AVCaptureDevice? {
        let cameras = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as! [AVCaptureDevice]
        for camera in cameras {
            if camera.position == position {
                return camera
            }
        }
        
        return nil
    }
    
    // 切换摄像头
    func switchCameraDevice(isFront front: Bool) {
        if front {
            stopCaptureSession()
            if let backCamera = backCameraInput, let frontCamera = frontCameraInput {
                captureSession.removeInput(backCamera)
                if captureSession.canAddInput(frontCamera) {
                    captureSession.addInput(frontCamera)
                    switchCameraAnimation()
                }
            }
        } else {
            stopCaptureSession()
            if let backCamera = backCameraInput, let frontCamera = frontCameraInput {
                captureSession.removeInput(frontCamera)
                if captureSession.canAddInput(backCamera) {
                    captureSession.addInput(backCamera)
                    switchCameraAnimation()
                }
            }
        }
    }
    
    // 切换摄像头动画
    func switchCameraAnimation() {
        let changeAnimation = CATransition()
        changeAnimation.delegate = self
        changeAnimation.duration = 0.45
        changeAnimation.type = "oglFlip"
        changeAnimation.subtype = kCATransitionFromRight
        previewLayer.add(changeAnimation, forKey: nil)
    }
    
    // 开关闪光灯
    func falshLight(isOpen open: Bool) {
        
    }
    
    // 拍摄照片
    func takePhotos(_ blcok: @escaping (UIImage) -> Void) {
        imageOutput.captureStillImageAsynchronously(from: imageConnection) { (imageDataBuffer, error) in
            if let imageBuffer = imageDataBuffer {
                if let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageBuffer) {
                    let tempImage = UIImage(data: imageData)
                    UIImageWriteToSavedPhotosAlbum(tempImage!, nil, nil, nil)
                    blcok(tempImage!)
                }
            }
        }
    }
    
    // 开始拍摄视频
    func startTakeVideo() {
        
    }
    
    // 停止拍摄视频
    func stopTakeVideo() {
        
    }
}

// MARK:

extension KYCameraManager: CAAnimationDelegate {
    
    func animationDidStart(_ anim: CAAnimation) {
        startCaptureSession()
    }
}

extension KYCameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    
}

extension KYCameraManager: AVCaptureAudioDataOutputSampleBufferDelegate {
    
}

