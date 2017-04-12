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
        
        self.setupSessionInputs()
        self.setupSessionOutputs()
        
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
    
    /// 视频连接
    var videoConnection = AVCaptureConnection()
    
    /// 音频连接
    var audioConnection = AVCaptureConnection()
    
    // MARK: - Private Methods
    
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
}

extension KYCameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    
}

extension KYCameraManager: AVCaptureAudioDataOutputSampleBufferDelegate {
    
}

