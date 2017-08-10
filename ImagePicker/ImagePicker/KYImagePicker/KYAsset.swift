//
//  KYAsset.swift
//  ImagePicker
//
//  Created by mac on 17/4/7.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import Photos

/// 相册中一个资源
class KYAsset: NSObject {
    
    var phAsset: PHAsset
    
    init(phAsset asset: PHAsset) {
        phAsset = asset
    }
    
    typealias assetSuccessBlock = (UIImage, NSDictionary) -> Void
    
    // MARK: - Public Api
    
    /// 请求原图
    func requestOriginImage(assetBlock block: @escaping assetSuccessBlock) -> PHImageRequestID {
        let requestOptions = PHImageRequestOptions()
        requestOptions.resizeMode = .fast
        
        return KYAssetManager.default.phCachingImageManger.requestImage(for: phAsset, targetSize:       PHImageManagerMaximumSize, contentMode: .default, options: requestOptions) { (result, info) in
            if let _result = result, let _info = info {
                block(_result, _info as NSDictionary)
            }
        }
    }
    
    /// 请求指定大小图
    func requestThumbnailImage(_ size: CGSize, assetBlock block: @escaping assetSuccessBlock) -> PHImageRequestID {
        let requestOptions = PHImageRequestOptions()
        requestOptions.resizeMode = .fast
        
        let scale = UIScreen.main.scale
        let newSize = CGSize(width: size.width * scale, height: size.height * scale)
        
        return KYAssetManager.default.phCachingImageManger.requestImage(for: phAsset, targetSize: newSize, contentMode: .aspectFill, options: requestOptions, resultHandler: { (result, info) in
            if let _result = result, let _info = info {
                block(_result, _info as NSDictionary)
            }
        })
    }
    
    /// 请求预览图
    func requestPreviewImage(assetBlock block: @escaping assetSuccessBlock) -> PHImageRequestID {
        let requestOptions = PHImageRequestOptions()
        requestOptions.resizeMode = .fast
    
        let size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        return KYAssetManager.default.phCachingImageManger.requestImage(for: phAsset, targetSize: size, contentMode: .aspectFill, options: requestOptions, resultHandler: { (result, info) in
            if let _result = result, let _info = info {
                block(_result, _info as NSDictionary)
            }
        })
    }
}

